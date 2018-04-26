class OrderDetail < ApplicationRecord
	belongs_to :order, dependent: :destroy
	belongs_to :product, dependent: :destroy
	validates :quantity, numericality: { greater_than_or_equal_to: 1 }

	def get_total
		self.total = self.product.price * self.quantity
	end

	def to_s
		self.quantity.to_s + self.total.to_s
	end
end
