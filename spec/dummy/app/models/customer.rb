class Customer < ActiveRecord::Base

  def adult_or_child_on(date)
    'adult'
  end
end
