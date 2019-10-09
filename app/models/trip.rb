class Trip < ApplicationRecord
  belongs_to :passenger  
  belongs_to :driver
  
  validates :date, presence: true
  validates :cost, presence: true
  
  # def replaced_deleted
  #   if @trip.passenger.nil?
  #     @trip.passenger = "[deleted]"
  #   elsif @trip.driver.nil?
  #     @trip.driver = "[deleted]"
  #   end
  # end
end
