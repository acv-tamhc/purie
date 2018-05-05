class CartsController < ApplicationController
	before_action :manupopulate_cart, only: [:index, :create]
	before_action :check_cart, only: [:new, :show]
	before_action :checkout, only: [:show, :update]
	def create
		if params[:order].nil?
			render :new
		else
			@order = Order.new(order_params)
			if @order.valid?
				session[:order] = order_params
				redirect_to cart_url('checkout')
			else
				render :new
			end
		end
	end
	def index
		@page_title = 'Cart'
		@total = 0
		unless session[:cart].empty?
			@cart = session[:cart]
			@cart.each { |k, v|
				o = session[:cart].fetch(k)
				unless o.nil?
					od = self.get_order_detail(o)
					@cart[k] = od
					@total += od.total.to_f
				end
			}
		end
		session[:cart_total] = @total
	end
	
	def new 
		@page_title = 'Address'
		@order = Order.new
	end

	def show
		@page_title = 'Checkout'
		
	end

	def update
		if  params[:update_checkout].nil?
			render :show
		else
			cart = session[:cart]
			@cart = Hash.new
			cart.each { |k, v|
				unless cart[k].nil?
					@cart[k] = self.get_order_detail(cart[k])
				end
			}
			if @order.save
				@cart.each { |k, v|
					item = @cart[k]
					item.order_id = @order.id
					item.save
				}
				session[:cart_total] = 0
				session[:cart] = nil
				session[:order] = nil
				redirect_to root_url
			end
		end
	end

	def checkout
		order = session[:order]
		@order = Order.new
		@order.email = order["email"]
		@order.phone = order["phone"]
		@order.address = order["address"]
		@order.description = order["description"]
		@order.total = session[:cart_total]
	end

	def get_order_detail(order_detail)
		@order_detail = OrderDetail.new
		@order_detail.product_id = order_detail["product_id"]
		@order_detail.quantity = order_detail["quantity"]
		@order_detail.get_total
		@order_detail
	end

	def add_cart(order_detail, type = 'add')
		product_id = order_detail[:product_id]
		od = OrderDetail.new
		if session[:cart][product_id].nil? || session[:cart][product_id].empty?
			od.product_id = product_id
			od.quantity = order_detail[:quantity]
			od.get_total
			session[:cart][product_id] = od
		else
			@order_detail_cart = session[:cart][product_id]
			od.product_id = @order_detail_cart['product_id']
			if type == 'add'
				od.quantity += 1
			else type == 'update'
				od.quantity = order_detail[:quantity]
			end
			od.get_total
			session[:cart][product_id] = od
			if type == 'remove'
				session[:cart][product_id] = nil
			end
		end
	end


	private

	def check_cart
		if session[:cart].empty?
			redirect_to carts_url
		end
	end

	def manupopulate_cart
		session[:cart] = Hash.new if session[:cart].nil?
		unless params[:order_detail].nil?
			order_detail = params[:order_detail]
			product_id = order_detail[:product_id]
			@result = Hash.new
			@result["status"] = false
			@result["message"] = "Not add to cart"
			if session[:cart][product_id].nil?
				self.add_cart(order_detail)
				@result["status"] = true
				@result["message"] = "Add to cart successful"
			else
				if params[:remove_cart].nil?
					self.add_cart(order_detail, 'update')
					@result["refresh"] = 1
					@result["message"] = "Update cart successful"
				else
					if params[:remove_cart].empty?
						self.add_cart(order_detail, 'update')
						@result["message"] = "Add to cart successful"
						@result["refresh"] = 1
					else
						self.add_cart(order_detail, 'remove')
						@result["refresh"] = 1
						@result["message"] = "Add to cart successful"
					end
				end
			end
			render json:@result
		end
	end

	def order_params
		params.require(:order).permit(:email, :phone, :address, :description)
	end

	def cart_params
  	params.require(:order_detail).permit(:quantity, :product_id)
  end
end
