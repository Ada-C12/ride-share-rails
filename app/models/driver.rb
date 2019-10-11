class Driver < ApplicationRecord
  validates :name, presence: true
  validates :vin, presence: true
  has_many :trips

  def self.find_available_driver
    all_drivers = self.all

    if all_drivers.empty?
      return nil
    end


    all_drivers.each do |driver|
      if !driver.active
        return driver.id
      end
    end

    return nil
  end

end
