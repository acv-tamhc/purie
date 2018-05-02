class RemoveColumnInStockOutStockInProducts < ActiveRecord::Migration[5.1]
  def change
  	remove_column :products, :viewer
  	remove_column :products, :galleries
  	remove_column :products, :in_stock
  	remove_column :products, :out_stock
  end
end
