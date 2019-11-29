class ChangePhoneToPhoneNum < ActiveRecord::Migration[5.2]
  def change
    remove_column :passengers, :phone
    add_column :passengers, :phone_num, :string
  end
end
