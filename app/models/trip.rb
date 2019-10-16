class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  def self.create_new_trip
    driver = Driver.all.find { |driver| driver.available }
    date = Date.today
    cost = rand(1000..5000)
    driver.update(available: false)

    return { driver_id: driver.id, date: date, cost: cost }
  end
end
