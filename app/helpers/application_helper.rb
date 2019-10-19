module ApplicationHelper
  
  def date_format(datetime)
    return Date.parse(datetime).strftime('%Y-%m-%d')
  end
end
