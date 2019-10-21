class Driver < ApplicationRecord
  validates :name, presence: true
  validates :vin, presence: true
  
  has_many :trips
  
  def total_earnings
    return "0.00" if trips.empty?  
    cents = trips.map do |trip|
      ((trip.cost - 165) * 80) / 100
    end.sum
    earnings = converter(cents)
  end
  
  
  def average_rating
    ratings = trips.map(&:rating).compact
    return "0.0" if ratings.empty?
    ((ratings.sum)/ratings.length.to_f).round(1).to_s
  end
  
  # Method to convert cents to dollars. Brute force. Returns a string with appropriate decimal point. No rounding, just string shuffling. 
  def converter(integer)
    integer = integer.to_s
    cents = integer[-2..-1]
    dollars = integer[0..-3]
    return_statement = "#{dollars}.#{cents}"
  end
  
end
