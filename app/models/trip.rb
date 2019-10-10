class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  attribute :date, :datetime, default: -> {Time.now}
end
