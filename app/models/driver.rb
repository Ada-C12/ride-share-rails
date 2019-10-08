class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  validates :name, presence: true
  validates :vin, presence: true
end
