class Passenger < ApplicationRecord

  validates :name, presence: true
  validates :phone_num, presence: true 

  #see the total amount the passenger has been charged

end
