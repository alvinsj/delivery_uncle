require 'spec_helper'

describe DeliveryUncle::EmailQueue do
  let(:email_request) { DeliveryUncle::EmailRequest.new }

  context 'change_status' do
    it 'should change request status' do
      DeliveryUncle::EmailQueue.pause(email_request)
      expect(email_request.status).to eql(:paused)
    end
  end
end 
