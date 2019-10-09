class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def request_a_ride
    
  end
  
  def complete_trip
    
  end
end
