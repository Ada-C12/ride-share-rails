class AddModelAndMakeColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :make, :string
    add_column :drivers, :model, :string
  end
end
