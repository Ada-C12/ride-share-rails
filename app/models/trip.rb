class Trip < ApplicationRecord
  belongs_to :passenger  
  belongs_to :driver  
  # def replaced_deleted
  #   if @trip.passenger.nil?
  #     @trip.passenger = "[deleted]"
  #   elsif @trip.driver.nil?
  #     @trip.driver = "[deleted]"
  #   end
  # end
end
