module DeliveryUncle
  class EmailQueue
    def self.change_status(request, status)
      case status
        when :queued
          QueueRequest.new(request)
        when :retry
          RetryRequest.new(request)
      end
      request.status = status
      request.save
    end

    class QueueRequest
      def initialize(request)
        Resque.enqueue(DeliveryUncle::SendEmailRequest, request.id)
      end
    end
    
    class RetryRequest
      def initialize(request)
        QueueRequest.new(request)
        request.retry_count += request.retry_count
      end
    end
  end
end
