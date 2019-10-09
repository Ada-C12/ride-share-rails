class Driver < ApplicationRecord
  validates :vin, presence: true
  validates :name, presence: true

  has_many :trips, dependent: :nullify

  def self.all_by_id_desc
    return Driver.all.order(id: :desc)
  end
end
