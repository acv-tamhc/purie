class AddReferenceOrderDetailsProduct < ActiveRecord::Migration[5.1]
  def change
  	add_reference :order_details, :product, index: true
  end
end
