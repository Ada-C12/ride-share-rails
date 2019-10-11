class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  def assign_rating
    self.update(rating: rand(1..5))
  end
end

