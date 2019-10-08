class Driver < ApplicationRecord
  has_many :trips
  # add validations here
  validates :name, :vin, presence: true
end
