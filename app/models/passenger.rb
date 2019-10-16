class Passenger < ApplicationRecord
  
  has_many :trips
  
  validates_presence_of :name, message: 'Name field cannot be empty!' 
  validates_presence_of :phone_num, message: 'Phone number field cannot be empty!' 
  
  def total_amount
    total = 0
    
    self.trips.each do |trip|
      cost = trip.cost
      total += cost
    end
    return '%.2f' % total
  end
  
end
