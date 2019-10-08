class Passenger < ApplicationRecord
  has_many :trips
  
  # #Validation Code
  # validates :name, presence: true;
  # validates :phone_num, presence: true, uniqueness: true
end
