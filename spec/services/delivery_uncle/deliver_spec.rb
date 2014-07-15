require 'spec_helper'

class SomeMailer < ActionMailer::Base
  default from: 'test@deliveryuncle.localhost'
  
  def test_mail(subject)
    mail(subject: subject, to: 'recepient@deliveryuncle.localhost')
  end
end

describe DeliveryUncle::Deliver do
  before do
    ResqueSpec.reset!
  end

  it "should receive email request" do
    delivery = DeliveryUncle::Deliver.new(SomeMailer, :test_mail, 'test_email')  
    DeliveryUncle::SendEmailRequest.should have_queued(delivery.request.id)
  end
end
