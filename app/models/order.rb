class Order < ApplicationRecord
	has_many :order_detail, dependent: :destroy
	validates :email, presence: true
	validates :phone, presence: true
	validates :address, presence: true
	validates :phone, presence: true, length: { minimum: 10, maximum: 11 }
end
