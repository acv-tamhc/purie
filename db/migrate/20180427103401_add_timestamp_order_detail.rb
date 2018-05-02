class AddTimestampOrderDetail < ActiveRecord::Migration[5.1]
  def change
  	change_table :order_details do |t|
      t.timestamps
    end
  end
end
