class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true 

  def self.alpha_passengers
    return Passenger.order(name: :asc)
  end 
end
