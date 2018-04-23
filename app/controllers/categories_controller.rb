class CategoriesController < ApplicationController
  def show
  	@products = Product.all
  end
end