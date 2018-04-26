class ProductsController < ApplicationController
	before_action :set_product, only: [:show]
  def show
    @product_related = @product.category.product.except(@product.id).take(6)
    session[:product_recent] = Array.new if session[:product_recent].nil?
    if session[:product_recent].count == 1
      @product_recent = Product.where("id = ? ", session[:product_recent].first).take(6)
    elsif session[:product_recent].count > 1
      @product_recent = Product.where("id IN (" + session[:product_recent].join(",") + ")").take(6)
    end
    
    session[:product_recent].push(@product.id) unless session[:product_recent].include? @product.id
    @social = Hash.new
    @social[:facebook] = 'https://www.facebook.com/sharer.php?s=100&p[url]=' + product_detail_path(@product.id)
    @social[:twitter] = 'https://twitter.com/intent/tweet?url=' + product_detail_path(@product.id)
    @social[:google] = 'https://plus.google.com/share?url=' + product_detail_path(@product.id)

    @order_detail = OrderDetail.new
    @order_detail.product = @product
  end

  private
  def set_product
  	@product = Product.find(params[:id]) unless params[:id].nil?
  end

  def category_params
  	params.require(:product).permit(:title, :description)
  end
end
