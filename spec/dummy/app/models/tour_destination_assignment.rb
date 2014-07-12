class TourDestinationAssignment < ActiveRecord::Base
  belongs_to :tour
  belongs_to :destination
  
#  acts_as_list :scope => :destination
end
