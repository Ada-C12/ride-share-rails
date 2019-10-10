class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :passenger_id, presence: true
  validates :driver_id, presence: true 
  validates :date, presence: true 

  def find_driver
    #Here is where we fid the driver
  end 
end
