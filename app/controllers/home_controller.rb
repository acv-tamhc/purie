class HomeController < ApplicationController
  def index
  	res = Amazon::Ecs.item_search('com', {:response_group => 'Medium', :sort => 'salesrank'})
    @results = res.items
    # res.items.each do |item|
    #   puts '--------------'
    #   puts item.get('ASIN')
    #   puts item.get('ItemAttributes/Title')
    # end
    
  end
end
