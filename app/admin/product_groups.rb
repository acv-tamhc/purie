ActiveAdmin.register ProductGroup do
	permit_params :title, :product_group_id, :group_nav, :picture, :link, :short, :meta_title, :meta_desc, :meta_key, :viewer, :lang
	#belongs_to :product_group
	#has_one :product_group
end
