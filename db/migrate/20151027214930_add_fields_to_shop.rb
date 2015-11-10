class AddFieldsToShop < ActiveRecord::Migration
  def change
    add_column :shops, :address, :string
    add_column :shops, :image_file_name, :string
  end
end
