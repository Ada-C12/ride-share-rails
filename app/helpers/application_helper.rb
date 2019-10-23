module ApplicationHelper

  def readable_date(date)
    return "[unknown]" unless date
    return (
      "<span class='date' title=' "date.to.s"' >".html_safe + 
			time_ago_in_words(date) + " ago</span>".html_safe
    )
  end

end
