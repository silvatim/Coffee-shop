class ChangeFieldInOrders < ActiveRecord::Migration
  def change
  	rename_column :orders, :name, :first_name
  	add_column :orders, :last_name, :string
  end
end
