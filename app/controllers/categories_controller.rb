class CategoriesController < ApplicationController
	before_action :set_category, only: [:show]
  def index
    @categories = Category.includes(:product).all if @category.blank?
    unless @categories.nil?
      @order_detail = Hash.new
      @categories.each { |c|
        c.product.each { |p|
          od = OrderDetail.new
          od.quantity = 1
          od.product_id = p.id
          @order_detail[c.id] = Hash.new if @order_detail[c.id].nil?
          @order_detail[c.id][p.id] = od
        }
      }
    end
  end

  def show
  end
  private 
  def set_category
  	@category = Category.find(params[:id]) unless params[:id].nil?
    @order_detail = Hash.new
    unless @category.nil?
      @category.product.each { |p|
        od = OrderDetail.new
        od.quantity = 1
        od.product_id = p.id
        @order_detail[p.id] = od
      }
    end
  end
  def category_params
  	params.require(:category).permit(:title, :description)
  end
end