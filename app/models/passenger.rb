class Passenger < ApplicationRecord
  has_many :trips
  
  def self.alpha_passengers
    return Passenger.order(name: :asc)
  end
  
  validates :name, presence: true, format: {with /\S+\s{1}/}
  validates :phone_number, presence: true, format: {with /\S+\s{1}/}
end
