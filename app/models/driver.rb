class Driver < ApplicationRecord
  has_many :trips

  def self.alpha_drivers
    return Driver.order(name: :asc)
  end
  validates :name, presence: true
  validates :vin, presence: true
end


  