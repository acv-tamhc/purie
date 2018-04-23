class CategoriesController < ApplicationController
  def show
  	@categories = Category.all
  	
  	puts @categories
  end
end