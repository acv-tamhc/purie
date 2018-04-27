class CreateOrderDetail < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
    	t.float :quantity, default: 1
    	t.float :total, default: 0 
    	t.timestamp
    end
  end
end
