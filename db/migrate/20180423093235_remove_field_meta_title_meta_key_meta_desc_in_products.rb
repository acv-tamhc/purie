class RemoveFieldMetaTitleMetaKeyMetaDescInProducts < ActiveRecord::Migration[5.1]
  def change
  	remove_column :products, :meta_title 
  	remove_column :products, :meta_desc 
  	remove_column :products, :meta_key 
  end
end
