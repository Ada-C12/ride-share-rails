class Driver < ApplicationRecord
  has_many :trips, dependent: :nullify
  
  validates :name, presence: true
  validates :vin, presence: true
  
  # Average rating
  
  # Total earnings
  
  # Can go online
  
  # Can go offline
end
