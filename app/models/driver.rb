class Driver < ApplicationRecord
  has_many :trips

  def self.alpha_drivers
    return Driver.order(name: :asc)
  end
end


  