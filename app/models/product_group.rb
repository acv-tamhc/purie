class ProductGroup < ApplicationRecord
	has_one :product_group
	validates :title, :picture, :link, :short, presence: true
	validate  :title_is_shorter_than_short

	def title_is_shorter_than_short
		return if title.blank? or short.blank?
		if short.length < title.length
			errors.add(:short, 'can\'t be shorter than title')
		end
	end
end
