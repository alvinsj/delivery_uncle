module DeliveryUncle
  class Deliver
    
    def initialize(mailer, mailer_method, *args)
      mail = mailer.send(mailer_method, *args)
       
      @request = DeliveryUncle::EmailRequest.new(
                    mail_body: mail.to_s,
                    mailer: mailer.to_s,
                    mailer_method: mailer_method,
                    status: :preparing,
                    mail_type: :deliver,
                    request_from: caller[1][/`.*'/][1..-2])

      
      deliver(@request) if @request.save!
    end

    private
    def deliver(request)
      Resque.enqueue(DeliveryUncle::SendEmailRequest, request.id) 
        
      request.status = :queued
      request.save
    end

  end
end
