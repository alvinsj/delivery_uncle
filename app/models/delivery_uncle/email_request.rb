module DeliveryUncle
  class EmailRequest < ActiveRecord::Base 
    scope :order_by_latest, -> { order('created_at DESC') }
    scope :not_sent, -> { where('status != ?', 'sent') }
    scope :with_mailer_method, ->(mailer, mailer_method) { where(mailer: mailer, mailer_method: mailer_method) }      

    def self.create(mailer, mailer_method, *args)
      mail = mailer.send(mailer_method, *args)
      raise 'mail with attachment is not supported yet' if mail.has_attachments? 

      request = DeliveryUncle::EmailRequest.new  
      request.mail_body = encode_mail(mail)
      request.mailer = mailer.to_s
      request.mailer_method = mailer_method
      request.status = :new
      request.mail_type = :deliver
      request.request_from = (caller[1][/`.*'/][1..-2] rescue nil)

      request
    end

    def self.encode_mail(mail)
      mail.header[:bcc] ? 
        mail.header[:bcc].do_encode('Bcc') << mail.encoded :
        mail.encoded
    end

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
