module DeliveryUncle
  class Deliver
    
    def initialize(mailer, mailer_method, *args)
      mail = mailer.send(mailer_method, *args)
       
      @request = DeliveryUncle::EmailRequest.new
      @request.mail_body = mail.to_s
      @request.mailer = mailer.to_s
      @request.mailer_method = mailer_method
      @request.status = :preparing
      @request.mail_type = :deliver
      @request.request_from = caller[1][/`.*'/][1..-2]
 
      deliver(@request) if @request.save!
    end
    
    def request
      @request
    end

    private
    def deliver(request)
      Resque.enqueue(DeliveryUncle::SendEmailRequest, request.id) 
        
      request.status = :queued
      request.save
    end

  end
end
