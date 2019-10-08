class RemoveDateColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :date
  end
end
