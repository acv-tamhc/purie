class AddTimestampOrder < ActiveRecord::Migration[5.1]
  def change
  	change_table :orders do |t|
      t.timestamps
    end
  end
end
