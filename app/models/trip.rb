class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  # validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  
  attribute :date, :datetime, default: -> {Time.now}
  
  attribute :cost, :float, default: -> {rand(1..100)}
end
