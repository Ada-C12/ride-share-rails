class Passenger < ApplicationRecord
  validates :name, presence: true
  validates :phone_num, presence: true
  has_many :trips

  def total_spent
    if self.trips == nil
      return 0
    end

    spent = self.trips.map do |trip|
      trip.cost
    end
    return spent.sum
  end

  def self.all_in_alpha_order
    return Passenger.all.order(name: :asc)
  end

    
end
