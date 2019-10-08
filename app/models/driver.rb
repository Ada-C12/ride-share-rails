class Driver < ApplicationRecord
  validates :vin, presence: true
  validates :name, presence: true
end
