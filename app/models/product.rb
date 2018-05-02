class Product < ApplicationRecord
	validates :title, presence: true
	validates :description, presence: true
	validates :item_code, presence: true
	validates :picture, presence: true
	validates :price, presence: true

	belongs_to :category, dependent: :destroy, optional: true
	validate  :title_is_description_than_short
	
	def title_is_description_than_short
		return if title.blank? or description.blank?
		if description.length < title.length
			errors.add(:description, 'can\'t be description than title')
		end
	end
end
