class AddReferenceProductGroupInProductGroup < ActiveRecord::Migration[5.1]
  def up
    add_reference :product_groups, :product_group, foreign_key: true
  end
  def down
    remove_column :product_groups, :product_group_id
  end
end
