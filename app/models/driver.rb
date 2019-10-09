class Driver < ApplicationRecord
  validates :name, presence: true
  validates :vin, presence: true
  has_many :trips
end
