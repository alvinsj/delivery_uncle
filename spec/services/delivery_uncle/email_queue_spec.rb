require 'spec_helper'

describe DeliveryUncle::EmailQueue do
  
  let(:email_request) do
    request = DeliveryUncle::EmailRequest.new
    request.status = :new
    request.save
    request
  end

  let(:sent_request) do
    request = DeliveryUncle::EmailRequest.new 
    request.status = :sent
    request.save
    request
  end

  context 'when email request is already sent' do
    it 'should not be allowed to change the status' do 
      DeliveryUncle::EmailQueue.pause(sent_request)
      expect(sent_request.status).to eql(:sent)

      DeliveryUncle::EmailQueue.retry(sent_request)
      expect(sent_request.status).to eql(:sent)

      DeliveryUncle::EmailQueue.queue(sent_request)
      expect(sent_request.status).to eql(:sent)
    end
  end 
  
  context '.pause' do
    it 'should change request status' do
      DeliveryUncle::EmailQueue.pause(email_request)
      expect(email_request.status).to eql(:paused)
    end
  end

  context '.queue' do
    before do
      ResqueSpec.reset!
    end

    it 'should queue to background' do
      DeliveryUncle::EmailQueue.queue(email_request)
      expect(DeliveryUncle::SendEmailRequest).to have_queued(email_request.id)
      expect(email_request.status).to eql(:enqueue)
    end
  end

  context '.retry' do
    it 'should change status to queue' do
      expect(email_request.status).to eql(:new)

      DeliveryUncle::EmailQueue.retry(email_request)
      expect(DeliveryUncle::SendEmailRequest).to have_queued(email_request.id)
      expect(email_request.status).to eql(:enqueue)
    end
  end
end 
