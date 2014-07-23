module DeliveryUncle
  class EmailRequest < ActiveRecord::Base 
    scope :order_by_latest, -> { order('created_at DESC') }
    scope :with_mailer_method, ->(mailer, mailer_method) {where(mailer: mailer, mailer_method: mailer_method)}      
    
    def mail
      ::Mail.new(mail_body)
    end
    
    def paused?
      status == :paused || status == 'paused'
    end

    def sent?
      status == :sent || status == 'sent'
    end
  end
end
