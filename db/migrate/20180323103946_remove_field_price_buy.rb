class RemoveFieldPriceBuy < ActiveRecord::Migration[5.1]
  def up
    remove_column :products, :price_buy
  end
  def down
  end
end
