class ChangeDriverActiveDatatype < ActiveRecord::Migration[5.2]
  def change
    remove_column :drivers, :active
    add_column :drivers, :active, :boolean
  end
end
