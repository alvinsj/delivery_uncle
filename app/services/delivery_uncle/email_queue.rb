module DeliveryUncle
  class EmailQueue
    module ClassMethods
      def queue(request)
        return if not_allowed?(request)
        
        QueueRequest.new(request)
        save_status(request, :queued)
      end

      def pause(request)
        return if not_allowed?(request)
        
        save_status(request, :paused)
      end

      def retry(request)
        return if not_allowed?(request)
        
        save_status(request, :retrying)
        RetryRequest.new(request)
        save_status(request, :queued)
      end
 
      def not_allowed?(request)
        return true if request.blank? || request.sent?

        if Activity.blocked_mailers.include?(request.mailer)
          save_status(request, :blocked)
          return true
        end

        return false
      end
     
      private
      def save_status(request, status)
        request.status = status
        request.save
      end
    end
    extend ClassMethods 
     
    protected
    class QueueRequest
      def initialize(request)
        Resque.enqueue(DeliveryUncle::SendEmailRequest, request.id)
      end
    end
    
    class RetryRequest
      def initialize(request)
        QueueRequest.new(request)
      end
    end  
  end
end
