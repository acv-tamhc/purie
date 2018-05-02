class RemoveTableProductGroups < ActiveRecord::Migration[5.1]
  def change
  	drop_table :product_groups
  end
end
