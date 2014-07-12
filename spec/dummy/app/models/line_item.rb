class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :saleable, polymorphic: true
  belongs_to :redeemable, polymorphic: true
end
