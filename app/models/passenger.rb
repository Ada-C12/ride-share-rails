class Passenger < ApplicationRecord
    has_many :trips

    validates :name, presence: true, format: { with: /\A[a-z\sA-Z]+\z/, message: "only allows letters" }
    validates :phone_num, presence: true
end
