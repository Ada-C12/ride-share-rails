class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver
  
  validates :date, presence: true
  validates :driver, presence: true
  validates :passenger, presence: true
  
end
