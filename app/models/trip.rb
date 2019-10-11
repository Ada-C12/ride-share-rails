class Trip < ApplicationRecord
  belongs_to :driver, optional: true
  belongs_to :passenger, optional: true

  validates :date, presence: true
  validates :cost, presence: true
end
