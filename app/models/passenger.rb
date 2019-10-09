class Passenger < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :phone_num, presence: true
  
  def standardize_phone 
    ### FUTURE ENHANCEMENT IDEA , for standardizing phone_num display string ###
  end
  
end
