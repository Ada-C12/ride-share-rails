class Passenger < ApplicationRecord
    has_many :trips, dependent: :nullify
    
    validates :name, presence: true
    validates :phone_num, presence: true
    
    def total_expense_to_dollars
        total_expense = self.trips.map {|trip| trip.cost }.sum
        return total_expense / 100.0
    end
    
    def request_trip
        first_available_driver = Driver.find_by(active: false)
        if first_available_driver
            passenger_id = self.id
            return {
                trip: {
                    date: Date.today,
                    rating: nil,
                    cost: rand(165..4000),
                    passenger_id: passenger_id,
                    driver_id: first_available_driver.id
                }
            }
        else
            return nil
        end
    end
    
    def complete_trip(trip)
        trip.driver.toggle_active
    end
end
