class Category < ApplicationRecord
	validates :title, :description, presence: true
	validate  :title_is_description_than_short

	def title_is_description_than_short
		return if title.blank? or description.blank?
		if description.length < title.length
			errors.add(:description, 'can\'t be description than title')
		end
	end
end
