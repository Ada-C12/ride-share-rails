class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :driver, :presence => true
  validates :passenger, :presence => true
end
