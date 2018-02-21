class AlterTableProductPublish < ActiveRecord::Migration[5.1]
  def up
  	add_column :products, :published, :boolean, :default => true 
  end
  def down
  	remove_column :products, :published, :boolean 
  end
end
