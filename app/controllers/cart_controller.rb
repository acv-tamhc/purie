class CartController < ApplicationController
	before_action :check_cart, only: [:address, :checkout]
	def cart
		@page_title = 'Cart'
		session[:cart] = Hash.new if session[:cart].nil?
		unless params[:order_detail].nil?
			@result = Hash.new
			@result["status"] = false
			@result["message"] = "Not add to cart"
			if session[:cart][params[:order_detail][:product_id]].nil?
				@order_detail = OrderDetail.new
				@order_detail.quantity = 1
				@order_detail.quantity = params[:order_detail][:quantity] unless params[:order_detail][:quantity].nil?
				@order_detail.product_id = params[:order_detail][:product_id] unless params[:order_detail][:product_id].nil?
				@order_detail.get_total
				session[:cart][@order_detail.product_id] = @order_detail
				@result["status"] = true
				@result["message"] = "Add to cart successful"
			else
				@order_detail = session[:cart][params[:order_detail][:product_id]]
				if params[:order_detail]['quantity'].nil?
					@order_detail['quantity'] = @order_detail['quantity'].to_f + 1
				else
					if params['update_cart'].nil?
						@order_detail['quantity'] = @order_detail['quantity'].to_f + params[:order_detail]['quantity'].to_f
					else
						@order_detail['quantity'] = params[:order_detail]['quantity'].to_f
						@result["refresh"] = 1
					end
				end
				@order_detail['total'] = @order_detail['quantity'] * Product.find(params[:order_detail]['product_id']).price
				session[:cart][params[:order_detail][:product_id]] = @order_detail
				@result["status"] = true
				@result["message"] = "Add to cart successful"
			end
			render json:@result
		end
		@total = 0
		unless session[:cart].empty?
			@cart = session[:cart]
			@cart.each { |k, v|
				o = session[:cart].fetch(k)
				od = OrderDetail.new
				od.product_id = o["product_id"]
				od.quantity = o["quantity"]
				od.total = o["total"]
				@total += o["total"].to_f
				@cart[k] = od
			}
		end
		session[:cart_total] = @total
	end
	def address 
		@page_title = "Address"
		@order = Order.new
		unless params[:order].nil?
			@order = Order.new(order_params)
			if @order.valid?
				session[:order] = order_params
				redirect_to cart_checkout_url
			end
		end
	end
	def checkout
		@page_title = "Checkout"
		cart = session[:cart]
		@cart = Hash.new
		cart.each { |k, v|
			od = OrderDetail.new
			od.product_id = v["product_id"]
			od.quantity = v["quantity"]
			od.total = v["total"]
			@cart[k] = od
		}
		@total = session[:cart_total]
		order = session[:order]
		@order = Order.new
		@order.email = order["email"]
		@order.phone = order["phone"]
		@order.address = order["address"]
		@order.description = order["description"]
		@order.total = @total

		unless params[:update_checkout].nil?
		#unless params[:abc].nil?
			if @order.save
				@cart.each { |k, v|
					item = @cart[k]
					item.order_id = @order.id
					item.save
				}
				# session[:cart_total] = 0
				# session[:cart] = nil
				# session[:order] = nil
				# redirect_to root_url
			end
		end

	end
	private
	def check_cart
		if session[:cart].empty?
			redirect_to cart_url
		end
	end
	def order_params
		params.require(:order).permit(:email, :phone, :address, :description)
	end
	def cart_params
  	params.require(:order_detail).permit(:quantity, :product_id)
  end
end
