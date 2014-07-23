require 'spec_helper'

describe DeliveryUncle::Deliver do
  before do
    ResqueSpec.reset!
    
    klass = Class.new(ActionMailer::Base)
    Object.const_set('TestMailer', klass)
    TestMailer.class_eval do
      default from: 'test@deliveryuncle.localhost'
  
      def test_mail(subject)
        mail(subject: subject, to: 'recepient@deliveryuncle.localhost')
      end
    end
  end

  after do
    Object.send(:remove_const, :TestMailer)
  end

  it "should receive email request" do
    delivery = DeliveryUncle::Deliver.new(TestMailer, :test_mail, 'test_email')
    DeliveryUncle::SendEmailRequest.should have_queued(delivery.request.id)
  end
end
