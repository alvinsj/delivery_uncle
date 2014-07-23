require_dependency "delivery_uncle/application_controller"

module DeliveryUncle
  class EmailRequestsController < ApplicationController

    def index
      requests = EmailRequest.order_by_latest
      pagination = paginate.page(requests, params)
     
      @requests = pagination.data
      @pagination = pagination
    end

    def pause
      EmailQueue.pause(email_request) if email_request.present?
      redirect_to email_requests_url
    end

    def pause_all
      if email_request.present?
        EmailRequest.
          with_mailer_method(email_request.mailer, email_request.mailer_method).
          each do |entry|
            EmailQueue.pause(entry)
          end
      end
      redirect_to email_requests_url
    end

    def retry
      EmailQueue.retry(email_request) if email_request.present?
      redirect_to email_requests_url
    end

    def retry_all
      if email_request.present?
        EmailRequest.
          with_mailer_method(email_request.mailer, email_request.mailer_method).
          each do |entry|
            EmailQueue.retry(entry)
          end
      end
      redirect_to email_requests_url
    end
    
    private
    def email_request
      return nil if params[:id].blank?
      @email_request ||= EmailRequest.find(params[:id])
    end
    
    PER_PAGE = 20
    def paginate
      Paginate.new(PER_PAGE)
    end
  end
end
