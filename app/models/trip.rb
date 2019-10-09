class Trip < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver
  
  validates :date, presence: true
  validates :driver, presence: true
  validates :passenger, presence: true
  
  def self.all_in_alpha_order
    return Trip.all.order(date: :asc)
  end
end
