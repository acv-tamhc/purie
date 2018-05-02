class ChangeTableProduct < ActiveRecord::Migration[5.1]
  def change
  	remove_column :products, :item_id
  	remove_column :products, :group_nav
  	remove_column :products, :group_id
  	remove_column :products, :item_related
  	remove_column :products, :lang
  end
end
