class CartController < ApplicationController
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
				order_detail = session[:cart][params[:order_detail][:product_id]]
				if params[:order_detail]['quantity'].nil?
					session[:cart][params[:order_detail]['product_id']][:quantity] = order_detail[:quantity] + 1
				else
					session[:cart][params[:order_detail]['product_id']][:quantity] = order_detail[:quantity].to_f + params[:order_detail]['quantity'].to_f					
				end
				session[:cart][params[:order_detail]['product_id']][:total] = order_detail[:quantity] * Product.find(params[:order_detail]['product_id']).price
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
				@total += o["total"]
				@cart[k] = od
			}
		end
	end
	private
	def cart_params
  	params.require(:order_detail).permit(:quantity, :product_id)
  end
end
