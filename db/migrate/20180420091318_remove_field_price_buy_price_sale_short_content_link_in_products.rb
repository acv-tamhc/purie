class RemoveFieldPriceBuyPriceSaleShortContentLinkInProducts < ActiveRecord::Migration[5.1]
  def change
  	#remove_column :products, :price_buy
  	remove_column :products, :price_sale
  	remove_column :products, :short
  	remove_column :products, :content
  	remove_column :products, :link
  end
end
