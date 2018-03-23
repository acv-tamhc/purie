class ChangeProduct < ActiveRecord::Migration[5.1]
  def up
    change_table :products do |t|
      t.change :item_id, :string
    end
  end
  def down
  end
end
