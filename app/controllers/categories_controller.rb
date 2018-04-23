class CategoriesController < ApplicationController
  def show
  	@categories = Category.includes(:product).all
  end
end