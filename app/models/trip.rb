class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  
  validates :date, presence: true
  validates :passenger_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :driver_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cost, presence: true
  # rating to be entered by passenger later, no need to validate on creation, maybe later @ update
  validates :rating, numericality: { allow_nil: true, only_integer: true, greater_than: 0 }
end
