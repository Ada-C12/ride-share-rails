class Passenger < ApplicationRecord
  has_many :trips
  def self.alpha_passengers
    return Passenger.order(name: :asc)
  end
end
