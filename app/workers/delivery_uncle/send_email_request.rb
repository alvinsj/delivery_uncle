module DeliveryUncle
  class SendEmailRequest
    @queue = "delivery_uncle:email_request"

    def self.perform(request_id)
      request = DeliveryUncle::EmailRequest.find(request_id)
      
      return if request.paused? || EmailQueue.not_allowed?(request)
      request.save_status!(:processing)
      
      begin 
        mail = request.mail
        method = ActionMailer::Base.delivery_method
        mail.delivery_method method, ActionMailer::Base.send(:"#{method}_settings")
        mail.deliver
        request.save_status!(:sent)
      rescue => e
        request.save_status!(:error_when_deliver)
        raise e
      end
    end
  end
end
