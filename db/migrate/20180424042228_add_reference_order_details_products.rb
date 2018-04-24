class AddReferenceOrderDetailsProducts < ActiveRecord::Migration[5.1]
  def change
  	add_reference :order_details, :products, index: true
  end
end
