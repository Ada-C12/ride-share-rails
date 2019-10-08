class Driver < ApplicationRecord
  validate :vin, presence: true
  validate :name, presence: true
end
