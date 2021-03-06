class CreateOrder < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string  :email
      t.string  :phone
      t.string  :address
      t.float   :total, default: 0
      t.string  :description
      t.timestamp
    end
  end
end
