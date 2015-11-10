class ChangeTypeFieldOnOrder < ActiveRecord::Migration
  def change
    rename_column :orders, :type, :coffee_type
  end
end
