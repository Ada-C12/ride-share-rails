class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def total_expense_to_dollars
    total_expense = self.trips.map {|trip| trip.cost }.sum
    return total_expense / 100.0
  end
end
