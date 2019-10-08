class AddForeignKey < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :trips, :drivers
    add_foreign_key :trips, :passengers
  end
end
