class Driver < ApplicationRecord
  has_many :trips

  def average_rating
    avg_rating = 0
    if self.trips != []
      avg_rating = self.trips.average(:rating).round
    end
    return avg_rating
  end
end
