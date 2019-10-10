class Passenger < ApplicationRecord
  validates :name, presence: true
  validates :phone_num, presence: true
  
  has_many :trips
  
  def total_charges
    
    dollars, cents = (trips.map(&:cost)).sum.divmod(100)
    
    "#{dollars}.#{cents}"
    
  end
end
