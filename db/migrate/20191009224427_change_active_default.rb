class ChangeActiveDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :drivers, :active, false
  end
end
