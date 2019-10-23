class AddAccountStatusToPassenger < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers, :account_status, :boolean
  end
end
