require 'spec_helper'

describe DeliveryUncle::EmailQueue do
  let(:email_request) { DeliveryUncle::EmailRequest.new }

  context 'change_status' do
    it 'should change request status' do
      DeliveryUncle::EmailQueue.change_status(email_request, :new)
      expect(email_request.status).to eql(:new)
    end
  end
end 
