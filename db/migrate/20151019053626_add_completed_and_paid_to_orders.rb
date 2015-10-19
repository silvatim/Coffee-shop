class AddCompletedAndPaidToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :completed_at, :timestamp
  	add_column :orders, :finished_at, :timestamp
  end
end
