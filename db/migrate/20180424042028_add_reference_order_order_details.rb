class AddReferenceOrderOrderDetails < ActiveRecord::Migration[5.1]
  def change
  	add_reference :order_details, :order, index: true
  end
end
