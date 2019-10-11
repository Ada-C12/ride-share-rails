class Passenger < ApplicationRecord
    has_many :trips, dependent: :nullify
    
    validates :name, presence: true
    validates :phone_num, presence: true
    
    def request_trip
        first_available_driver = Driver.find_by(active: false)
        passenger_id = self.id
        return Trip.new(
            date: Date.today,
            rating: nil,
            cost: rand(165..4000),
            passenger_id: passenger_id,
            driver_id: first_available_driver.id
        )
    end

    def complete_trip(trip)
        trip.driver.toggle_active
    end
end
