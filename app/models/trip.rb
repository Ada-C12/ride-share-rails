class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :passenger_id, presence: true
  validates :driver_id, presence: true

  def assign_rating
    self.update(rating: rand(1..5))
  end
end

