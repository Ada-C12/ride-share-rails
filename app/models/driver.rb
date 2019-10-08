class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true, length: { in: 10..22 } #format: {with: /}
end
