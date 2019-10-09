class Driver < ApplicationRecord
    has_many :trips

    validates :name, presence: true, format: { with: /\A[a-z\sA-Z]+\z/, message: "only allows letters" }
    validates :vin, presence: true, uniqueness: true
end
