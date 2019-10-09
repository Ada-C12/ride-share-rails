class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def average_rating
    total_rating = trips.map{|trip| trip.rating }.sum
    if trips.length != 0
      return (total_rating.to_f / trips.length).round(1)
    end
    return nil
  end
end