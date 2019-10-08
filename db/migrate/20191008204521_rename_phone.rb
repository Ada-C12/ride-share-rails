class RenamePhone < ActiveRecord::Migration[5.2]
  def change
    rename_column :passengers, :phone, :phone_num
  end
end
