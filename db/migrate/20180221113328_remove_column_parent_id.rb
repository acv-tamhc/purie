class RemoveColumnParentId < ActiveRecord::Migration[5.1]
  def change
  	remove_column :product_groups, :parent_id
  end
end
