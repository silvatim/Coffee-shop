class AddEstimateToOrder < ActiveRecord::Migration
  def change
  	add_column :orders, :estimate_taken, :timestamp 
  	add_column :orders, :estimate_given, :integer
  end
end
