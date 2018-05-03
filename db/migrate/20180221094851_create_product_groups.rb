class CreateProductGroups < ActiveRecord::Migration[5.1]
  def up
    create_table :product_groups do |t|
      t.integer 	:group_id
      t.string 		:group_nav
      t.string    :parent_id
      t.string		:picture
      t.string		:title
      t.string		:link
      t.text			:short
      t.string		:meta_title
      t.string		:meta_key
      t.string		:meta_desc
      t.integer		:viewer
      t.string		:lang
      t.timestamps	
    end
  end
  def down
    drop_table :product_groups
  end
end
