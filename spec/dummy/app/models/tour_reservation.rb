class TourReservation < ActiveRecord::Base
  belongs_to :departure
  has_many :tour_participants
  has_many :line_items, :as => 'saleable', :dependent => :destroy
end

