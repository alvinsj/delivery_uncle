module DeliveryUncle
  class EmailQueue
    module ClassMethods
      def queue(request)
        return if not_allowed?(request)
        
        QueueRequest.new(request)
      end

      def pause(request)
        return if not_allowed?(request)
        
        request.save_status!(:paused)
      end

      def retry(request)
        return if not_allowed?(request)
        
        RetryRequest.new(request)
      end
 
      def not_allowed?(request)
        return true if request.blank? || request.sent?

        if Activity.blocked_mailers.include?(request.mailer)
          request.save_status!(:blocked)
          return true
        end

        return false
      end
    end
    extend ClassMethods 
     
    protected
    class QueueRequest
      def initialize(request)
        request.save_status!(:enqueue)
        begin
          Resque.enqueue(DeliveryUncle::SendEmailRequest, request.id)
        rescue => e
          Rails.logger.error e.message
          Rails.logger.error e.backtrace.join("\n")
          request.save_status!(:error_on_enqueue)
        end
      end
    end
    
    class RetryRequest
      def initialize(request)
        request.save_status!(:retrying)
        QueueRequest.new(request)
      end
    end  
  end
end
