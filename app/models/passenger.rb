class Passenger < ApplicationRecord
  has_many :trips
  # add validations here
  validates :name, :phone, presence: true

  def find_passenger_trips
    return self.trips.all
    
  end
end
