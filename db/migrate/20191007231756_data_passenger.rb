class DataPassenger < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers, :name, :string
    add_column :passengers, :phone_num, :string
  end
end
