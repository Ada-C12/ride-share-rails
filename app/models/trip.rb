class Trip < ApplicationRecord
  
  belongs_to :driver
  belongs_to :passenger

  # def assign_driver
  #   @drivers.each do |driver|
  #     if driver.available
  #       driver.available = false
  #       return driver
  #     end
  #   end
  # end

end
