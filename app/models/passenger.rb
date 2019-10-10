class Passenger < ApplicationRecord
    has_many :trips, dependent: :nullify

    validates :name, presence: true
    validates :phone_num, presence: true

    def total_expense
        return self.trips.map {|trip| trip.cost }.sum
    end
end
