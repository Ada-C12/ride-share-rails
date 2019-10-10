class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true

  def find_driver
    driver = Driver.find_by(active: false)
    return driver
  end
end
