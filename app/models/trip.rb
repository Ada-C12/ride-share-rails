class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :driver, presence: true
  validates :passenger, presence: true
  delegate :driver_id, to: :driver, prefix: true
  
  
end
