class Trip < ApplicationRecord
    belongs_to :driver, dependent: :nullify
    belongs_to :passenger, dependent: :nullify

    validates :date, presence: true
    validates :rating, allow_nil: true, numericality: { less_than_or_equal_to: 5 }
    validates :passenger_id, presence: true
    validates :driver_id, presence: true
    validates :cost, presence: true

    def cost_to_dollars
      return (self.cost / 100.00).round(2)
    end
end
