module ApplicationHelper
  
  def display_date(date_obj)
    return date_obj.strftime("%b %d, %Y")
    
    # In case we want to add time into the display
    # return date_obj.strftime("%b %d, %Y, %l:%M %p")
  end
  
  def usd(cents_float)
    # cents is coming from database as a float...
    return format("$%.2f", cents_float/100.0)
  end
  
  def get_passenger_from_id(int)
    @passenger = Passenger.find_by(id: int)
    if @passenger 
      return @passenger
    else
      return nil
    end
  end
  
  def get_passenger_name_from_id(int)
    @passenger = get_passenger_from_id(int)
    return @passenger.name 
  end
  
  def get_driver_from_id(int)
    @driver = Driver.find_by(id: int)
    if @driver 
      return @driver
    else
      return nil
    end
  end
  
  def get_driver_name_from_id(int)
    @driver = get_driver_from_id(int)
    return @driver.name 
  end
  
end
