class AddDateColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :date, :date

  end
end
