class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  ### Passenger.account_status meant to track whether or not passenger.destroy()'d, but we're gonna use the dependent: :nullify for that instead
  
  validates :name, presence: true
  validates :phone_num, presence: true
  
  
  def standardize_phone 
    ### FUTURE ENHANCEMENT IDEA , for standardizing phone_num display string ###
  end
end
