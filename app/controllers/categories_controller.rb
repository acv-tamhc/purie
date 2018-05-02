class CategoriesController < ApplicationController
	before_action :set_category, only: [:show]
  def show
  	@categories = Category.includes(:product).all if @category.blank?
  end
  private 
  def set_category
  	@category = Category.find(params[:id]) unless params[:id].nil?
  end
  def category_params
  	params.require(:category).permit(:title, :description)
  end
end