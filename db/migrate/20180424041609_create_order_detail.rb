class CreateOrderDetail < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
    	t.float :quantity
    	t.float :total 
    	t.timestamp
    end
  end
end
