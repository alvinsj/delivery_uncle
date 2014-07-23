require_dependency "delivery_uncle/application_controller"

module DeliveryUncle
  class EmailRequestsController < ApplicationController

    def index
      requests = EmailRequest.order_by_latest
      pagination = paginate.page(requests, params)
     
      @requests = pagination.data
      @pagination = pagination
    end

    def show
      @request = email_request 
    end

    def pause
      EmailQueue.pause(email_request) if email_request.present?
      redirect_to email_requests_url
    end

    def pause_all
      if email_request.present?
        EmailRequest.
          not_sent.
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
          not_sent.
          with_mailer_method(email_request.mailer, email_request.mailer_method).
          each do |entry|
            EmailQueue.retry(entry)
          end
      end
      redirect_to email_requests_url
    end
  
    def configure
      @mailers = union_of_mailers - Activity.blocked_mailers
      @blocked_mailers = Activity.blocked_mailers
    end

    def block
      mailer ? 
        act_on_mailer(:block_mailer, mailer) :
        error_mailer_not_found
      redirect_to action: :configure
    end

    def unblock
      mailer ? 
        act_on_mailer(:unblock_mailer, mailer) : 
        error_mailer_not_found
      redirect_to action: :configure
    end
    
    private
    def error_mailer_not_found
      flash[:error] = "Mailer not found."
    end
      
    def mailer
      return nil if params[:mailer].blank?
      union_of_mailers.include?(params[:mailer]) ? 
        params[:mailer] : nil
    end
    
    def union_of_mailers
      (MAILERS | EmailRequest.mailers).sort
    end

    def act_on_mailer(verb, mailer)
      activity = Activity.new
      activity.actor = current_user_email
      activity.verb = verb
      activity.object_type = mailer
      activity.save!
    end

    def current_user_email
      :user
    end

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
