require 'resque-loner'
require 'resque-history'

module DeliveryUncle
  class SendEmailRequest
    @queue = "delivery_uncle:email_request"

    def self.perform(request_id)
      request = DeliveryUncle::EmailRequest.find(request_id)
      
      return if request.paused?
      change_status(request, :processing)
      
      @queue = "delivery_uncle:#{request.mail_type}" if request.mail_type
      
      begin 
        request.mail.deliver
        change_status(request, :sent)
      rescue
        change_status(request, :error_when_deliver)
      end
    end

    def self.change_status(request, status)
      request.status = status
      request.save
    end
  end
end
