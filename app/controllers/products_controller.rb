class ProductsController < ApplicationController
	before_action :set_product, only: [:show]
  def show
  	@product_recent = @product.category.product.where("id != ?", @product.id).take(6)
  end

  private
  def set_product
  	@product = Product.find(params[:id]) unless params[:id].nil?
  end

  def category_params
  	params.require(:product).permit(:title, :description)
  end
end
