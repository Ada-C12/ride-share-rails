class Trip < ApplicationRecord
  validates :date, presence: true
  validates :passenger_id, presence: true, numericality: true
  validates :driver_id, presence: true, numericality: true
  validates :cost, presence: true, numericality: true
  belongs_to :driver 
  belongs_to :passenger
end
