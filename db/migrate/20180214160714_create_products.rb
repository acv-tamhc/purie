class CreateProducts < ActiveRecord::Migration[5.1]
  def up
    create_table :products do |t|
    	t.integer   :item_id
    	t.string 	:group_nav
    	t.integer   :group_id
    	t.string	:item_related
    	t.string	:item_code
    	t.string	:picture
    	t.string	:galleries
    	t.string	:title
    	t.float		:price
    	t.float		:price_buy
    	t.float		:price_sale
    	t.text		:short
    	t.text		:content
    	t.string	:link
    	t.string	:meta_title
    	t.string	:meta_key
    	t.string	:meta_desc
    	t.integer	:in_stock
    	t.integer	:out_stock
    	t.integer	:viewer
    	t.string	:lang
    	t.timestamps
    end
  end
  def down
    drop_table :products
  end
end
