class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true

  # def self.all
  #   return Passenger.all #Passenger.all
  # end

  def total_money_spent
    total_money_spent = 0
    if self.trips != []
      total_money_spent = self.trips.sum(:cost).round
    end
    return total_money_spent
  end
end