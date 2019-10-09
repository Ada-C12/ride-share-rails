class Driver < ApplicationRecord
  
  def change
    remove_column :books, :author
  end
  
end
