class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  validates :name, presence: true
  validates :phone_number, presence: true
end
