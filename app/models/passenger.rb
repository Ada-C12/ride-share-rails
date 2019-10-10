class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true

  # def self.all
  #   return Passenger.all #Passenger.all
  # end

  # def self.total_money_spent
  #   total_money_spent = self.passengers.where.not(publication_date: nil)
  #   first_book = books_with_year.order(publication_date: :asc).first
  #   return first_book.publication_date
  # end
end