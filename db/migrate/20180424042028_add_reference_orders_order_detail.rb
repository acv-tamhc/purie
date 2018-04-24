class AddReferenceOrdersOrderDetail < ActiveRecord::Migration[5.1]
  def change
  	add_reference :order_details, :orders, index: true
  end
end
