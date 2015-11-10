class ChangeFieldOnOrder < ActiveRecord::Migration
  def change
    rename_column :orders, :order, :comment
  end
end
