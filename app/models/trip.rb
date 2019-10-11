class Trip < ApplicationRecord
  belongs_to :passenger, optional: true
  belongs_to :driver, optional: true
  
  def self.all_trips
    return self.all.order(date: :desc)
  end
end
