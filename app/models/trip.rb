class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  attribute :date, :datetime, default: -> {Time.now}
  attribute :price, :float, default: -> {(1..100).rand}
end
