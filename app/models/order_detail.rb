class OrderDetail < ApplicationRecord
	belongs_to :order, dependent: :destroy, optional: true
	belongs_to :product, dependent: :destroy, optional: true
	validates :quantity, numericality: { greater_than_or_equal_to: 1 }

	def get_total
		self.total = self.product.price * self.quantity
	end
end
