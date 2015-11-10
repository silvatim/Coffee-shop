class AddChangeFieldsToShop < ActiveRecord::Migration
  def change
   rename_column :shops, :name, :street_num
   rename_column :shops, :description, :street
   rename_column :shops, :address, :suburb
   add_column :shops, :state, :string
   add_column :shops, :postcode, :string
   remove_column :shops, :image_file_name
  end
end
