class Product < ApplicationRecord
	belongs_to :categories, dependent: :destroy
end
