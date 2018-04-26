class ChangeFieldOrders < ActiveRecord::Migration[5.1]
  def change
  	change_table :orders do |t|
		  t.change :description, :text
		end
  end
end
