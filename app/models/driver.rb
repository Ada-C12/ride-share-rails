class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true
  validates :vin, presence: true
  
  def self.all_in_alpha_order
    return Driver.all.order(name: :asc)
  end
end
