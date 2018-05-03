class AlterTableProductGroupPublish < ActiveRecord::Migration[5.1]
  def up
    add_column :product_groups, :published, :boolean, :default => true
  end
  def down
    remove_column :product_groups, :published, :boolean 
  end
end
