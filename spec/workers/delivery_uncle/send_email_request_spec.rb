require 'spec_helper'

describe DeliveryUncle::SendEmailRequest do
  
  context '.perform' do
    
    context 'when request_id not found' do
      it 'should raise error when request not found' do
        expect do
          DeliveryUncle::SendEmailRequest.perform(999)   
        end.to raise_error
      end
    end

    context 'when request_id is found' do
      before :each do
        klass = Class.new(ActionMailer::Base)
        Object.const_set('TestMailer', klass)
        TestMailer.class_eval do
          default from: 'test@deliveryuncle.localhost'
      
          def test_email_method(subject)
            mail(subject: subject, to: 'recepient@deliveryuncle.localhost')
          end
        end
      end
  
      after :each do
        Object.send :remove_const, :TestMailer
      end
  
      let(:email_request) do
        request = DeliveryUncle::EmailRequest.new
        request.mailer = 'TestMailer'
        request.mailer = 'test_email_method'
        request.mail_body = TestMailer.test_email_method('hello test').to_s
        request.status = 'new'
        request.save
        request
      end
   
      it 'should send the email' do
        expect(email_request.status).to eql('new')
        DeliveryUncle::SendEmailRequest.perform(email_request.id)
        expect(email_request.mail).to deliver_to('recepient@deliveryuncle.localhost')
        expect(email_request.reload.status).to eql('sent')
      end
    end
  
  end
  
end
