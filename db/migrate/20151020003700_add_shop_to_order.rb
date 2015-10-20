class AddShopToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :shop_id, :integer, references: :shops
  end
end
