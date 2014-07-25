require 'spec_helper'

describe DeliveryUncle::Deliver do
  before do
    ResqueSpec.reset!
    
    klass = Class.new(ActionMailer::Base)
    Object.const_set('TestMailer', klass)
    TestMailer.class_eval do
      default from: 'test@deliveryuncle.localhost'
  
      def test_email_method(subject)
        mail(subject: subject, to: 'recepient@deliveryuncle.localhost')
      end
    end
  end

  after do
    Object.send(:remove_const, :TestMailer)
  end

  it "should receive email request" do
    delivery = DeliveryUncle::Deliver.new(TestMailer, :test_email_method, 'test_email')
    
    expect(delivery.request.mailer.to_s).to eql('TestMailer')
    expect(delivery.request.mailer_method.to_s).to eql('test_email_method')
    expect(delivery.request.mail.subject).to eql('test_email')
    expect(delivery.request.status).to eql(:enqueue)
    
    DeliveryUncle::SendEmailRequest.should have_queued(delivery.request.id)
  end
end
