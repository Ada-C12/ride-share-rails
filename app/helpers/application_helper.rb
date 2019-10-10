module ApplicationHelper
  def display_date(date_obj)
    return date_obj.strftime("%b %d, %Y")
    
    # In case we want to add time into the display
    # return date_obj.strftime("%b %d, %Y, %l:%M %p")
  end
end
