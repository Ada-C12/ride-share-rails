class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true

  # def self.all
  #   return passenger.name #Passenger.all
  # end

  # def self.total_money_spent
  #   books_with_year = self.books.where.not(publication_date: nil)
  #   first_book = books_with_year.order(publication_date: :asc).first
  #   return first_book.publication_date
  # end
end