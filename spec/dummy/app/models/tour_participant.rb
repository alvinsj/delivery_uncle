class TourParticipant < ActiveRecord::Base
  belongs_to :tour_reservation
  belongs_to :participant, class_name: Customer
  attr_accessor :nationality
end
