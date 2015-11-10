class AddFieldsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :milk, :string
    add_column :orders, :size, :string
    add_column :orders, :type, :string
    add_column :orders, :pickup_time, :datetime
    add_column :orders, :price, :decimal
  end
end
