class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true
  
  def total_money_spent
    total_money_spent = 0
    if self.trips != []
      total_money_spent = (self.trips.sum(:cost).round * 0.01)
    end
    return total_money_spent
  end

end