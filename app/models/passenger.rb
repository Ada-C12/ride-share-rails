class Passenger < ApplicationRecord
  has_many :trips
  # add validations here
  validates :name, :phone, presence: true
end
