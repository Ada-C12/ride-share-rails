class Passenger < ApplicationRecord
  validates :name, presence: true
  validates :phone_num, presence: true
  
  has_many :trips
  
  def total_charges
    
    cents = (trips.map(&:cost)).sum
    
    charge = converter(cents)
    
  end
  
  # Method to convert cents to dollars. Brute force. Returns a string with appropriate decimal point. No rounding, just string shuffling. 
  def converter(integer)
    integer = integer.to_s
    cents = integer[-2..-1]
    dollars = integer[0..-3]
    return_statement = "#{dollars}.#{cents}"
  end
  
end
