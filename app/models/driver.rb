class Driver < ApplicationRecord
  validates :vin, presence: true
  validates :name, presence: true

  has_many :trips, dependent: :nullify

  def self.all_by_id_desc
    return Driver.all.order(id: :desc)
  end

  def all_trips
    return self.trips.order(date: :desc) 
  end

  def self.available_driver
    available_drivers = Driver.where(active: false)
    if available_drivers.empty?
      return nil
    else
    available_driver = available_drivers.sample
    end

    return available_driver
  end

  def toggle_active
    self.toggle!(:active)
  end

end
