class Trip < ApplicationRecord
  belongs_to :passenger, optional: true
  belongs_to :driver, optional: true
end
