class Passenger < ApplicationRecord
  has_many :trips, dependent: :nullify
  validates :phone_num, presence: true
  validates :name, presence: true
  
  def total_charged
    total = 0
    self.trips.each do |trip|
      total += trip.cost
    end
    return total
  end
  
  def avatar_image
    passenger_id = self.id
    avatar_link = "https://api.adorable.io/avatars/200/" << passenger_id.to_s << ".png"
    
    return avatar_link
  end
  
end

