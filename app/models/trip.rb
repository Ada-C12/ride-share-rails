class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  
  def converter
    cost = @trip.cost
    @converted_cost = converter(cost)
  end
  
  def converter(integer)
    integer = integer.to_s
    cents = integer[-2..-1]
    dollars = integer[0..-3]
    return_statement = "#{dollars}.#{cents}"
  end
  
end
