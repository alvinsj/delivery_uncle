module DeliveryUncle
  class Deliver
    
    def initialize(mailer, mailer_method, *args)
     
      @request = DeliveryUncle::EmailRequest.create(mailer, mailer_method, *args)
      deliver(@request) if @request.save!
    end
    
    def request
      @request
    end

    private
    def deliver(request)
      EmailQueue.queue(request)
    end
  end
end
