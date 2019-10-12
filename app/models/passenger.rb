class Passenger < ApplicationRecord
  has_many :trips
  
  def self.alpha_passengers
    return Passenger.order(name: :asc)
  end
  
  validates :name, presence: true
  validates :phone_number, presence: true
end
