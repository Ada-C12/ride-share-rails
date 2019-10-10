class Passenger < ApplicationRecord
    has_many :trips, dependent: :nullify
end
