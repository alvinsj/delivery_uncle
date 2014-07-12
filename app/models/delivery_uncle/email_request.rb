module DeliveryUncle
  class EmailRequest < ActiveRecord::Base 
    def mail
      ::Mail.new(mail_body)
    end
  end
end
