class RemoveModelAndMakeColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :drivers, :make
    remove_column :drivers, :model
  end
end
