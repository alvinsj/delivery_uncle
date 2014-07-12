class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :agent
  has_many :line_items
  
  attr_accessor :balance_paid_date, :deposit_paid_date, :balance
end
