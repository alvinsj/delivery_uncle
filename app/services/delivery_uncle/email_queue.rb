module DeliveryUncle
  class EmailQueue
    module ClassMethods
      def queue(request)
        QueueRequest.new(request)
        save_status(request, :queued)
      end

      def pause(request)
        save_status(request, :paused)
      end

      def retry(request)
        save_status(request, :retrying)
        RetryRequest.new(request)
        save_status(request, :queued)
      end
   
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
