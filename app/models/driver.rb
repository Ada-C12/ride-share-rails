class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  # validates :active, presence: true
  validates :car_make, presence: true
  validates :car_model, presence: true
  
  def self.alpha_drivers
    return Driver.order(name: :asc)
  end 
end
