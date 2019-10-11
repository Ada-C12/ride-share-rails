class Passenger < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :phone_num, presence: true
  
  # I need to update so the cost shows in $
  def total_amount_charged  
    sum = 0  
    self.trips.each do |trip|
      sum += trip.cost
    end
    return sum/100.0
  end  
end 

