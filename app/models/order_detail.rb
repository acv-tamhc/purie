class OrderDetail < ApplicationRecord
	belongs_to :order, dependent: :destroy
	belongs_to :product, dependent: :destroy
	validates :quantity, numericality: { greater_than_or_equal_to: 1 }
end
