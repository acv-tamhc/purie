class ProductGroup < ApplicationRecord
	#belongs_to :product_group
	has_one :product_group
end
