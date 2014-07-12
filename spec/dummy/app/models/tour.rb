class Tour < ActiveRecord::Base
  has_many :tour_destination_assignment
  has_many :destinations, through: :tour_destination_assignment
end
