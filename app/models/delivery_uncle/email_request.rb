module DeliveryUncle
  class EmailRequest < ActiveRecord::Base 
    scope :order_by_latest, -> { order('created_at DESC') }
    scope :not_sent, -> { where('status != ?', 'sent') }
    scope :with_mailer_method, ->(mailer, mailer_method) { where(mailer: mailer, mailer_method: mailer_method) }      
    
    def mail
      @mail ||= ::Mail.new(mail_body)
    end
    
    def paused?
      status == :paused || status == 'paused'
    end

    def sent?
      status == :sent || status == 'sent'
    end
    
    def save_status!(status)
      update_attribute(:status,status)
    end
    
    def self.mailers
      group(:mailer).order('mailer ASC').map(&:mailer)
    end
  end
end
