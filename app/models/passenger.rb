class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def all_trips
    return self.trips.order(date: :desc) 
  end
  
  def net_expenditures
    #return total amount of money that passenger has spent on their trips
    total = 0
    self.trips.each do |trip|
      unless trip.cost == nil
        total += trip.cost
      end
    end
    return total
  end
  
end
