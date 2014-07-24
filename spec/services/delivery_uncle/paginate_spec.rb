require 'spec_helper'

describe DeliveryUncle::Paginate do
  
  context 'pagination' do
    before(:each) do
      (1..39).each do |n|
        a = DeliveryUncle::EmailRequest.new
        a.mailer = "mailer_#{n}"
        a.save
      end
    end

    after(:each) do
      DeliveryUncle::EmailRequest.destroy_all
    end
    
    it 'should show correct page 1 on 10/page' do
      pagination = DeliveryUncle::Paginate.new(10)
      pagination.page(DeliveryUncle::EmailRequest, {})
      
      expect(pagination.data.count).to eql(10)
      expect(pagination.data.first.mailer).to eql("mailer_1")
      expect(pagination.data.last.mailer).to eql("mailer_10")
    end
    
    it 'should show correct page 2 on 20/page' do
      pagination = DeliveryUncle::Paginate.new(20)
      pagination = pagination.page(DeliveryUncle::EmailRequest, {page: 2})
      
      expect(pagination.data.count).to eql(19)
      expect(pagination.data.first.mailer).to eql("mailer_21")
      expect(pagination.data.last.mailer).to eql("mailer_39") 
    end

    it 'should show correct url with next page' do
      pagination = DeliveryUncle::Paginate.new(10)
      pagination = pagination.page(DeliveryUncle::EmailRequest, {})
      
      expect(pagination.prev_page_url).to be_nil
      expect(pagination.next_page_url).to eql({page: 2})
    end

    it 'should show correct url with prev page' do
      pagination = DeliveryUncle::Paginate.new(10)
      pagination = pagination.page(DeliveryUncle::EmailRequest, {page: 2})
      
      expect(pagination.prev_page_url).to eql({page: 1})
      expect(pagination.next_page_url).to eql({page: 3}) 
    end

  end
 
end
