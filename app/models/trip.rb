class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver

  def self.find_driver
    @drivers = Driver.all

    @drivers.each do |driver|
      if driver.status == "available"
        driver_id = driver.id
        return driver_id
      end
    end
  end


end

# want method that takes in the driver_id of the associated trip and edit the rating of that trip with an if else
# statement that will update rating if it is nil.
