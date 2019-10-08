class Driver < ApplicationRecord
  has_many :trips
  
  ##Validation Code
  #validates :name, presence: true;
  #validates :vin presence: true, uniqueness: true
end
