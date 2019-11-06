class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  
  #Validation Code
  
  def trip_cost
    random_cost = (rand(100.00..500.99)).round(2)
    return random_cost
  end
  
end
