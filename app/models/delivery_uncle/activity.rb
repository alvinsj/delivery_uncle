module DeliveryUncle
  class Activity < ActiveRecord::Base 
    scope :not_expired, -> { where("expired is null or expired = 0")}
    scope :with_object_type, ->(object_type) { where(object_type: object_type) }
    scope :with_verb, ->(verb) { where(verb: verb) }
    
    validates_presence_of :actor, :verb, :object_type
    after_create :expire_blocked_mailers
    
    def expire_blocked_mailers
      case verb
      when :unblock_mailer
        self.class.with_verb(:block_mailer).with_object_type(object_type).each do |activity|
          activity.expired = true
          activity.save
        end
      end
    end

    def self.blocked_mailers
      not_expired.with_verb(:block_mailer).map(&:object_type)
    end

  end
end
