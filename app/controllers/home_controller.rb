class HomeController < ApplicationController
  def index
    res = Amazon::Ecs.item_search('com', {:response_group => 'Medium', :sort => 'salesrank'})
    @results = res.items
    rs = []
    item_price = ''
    res.items.each do |item|

      product = {}
      product[:title] = item.get('ItemAttributes/Title')
      product[:picture] = item.get_hash('LargeImage')['URL']
      product[:item_code] = item.get('ASIN')
      item_price = Amazon::Ecs.item_search({:IdType => 'ASIN', :ItemId => item.get('ASIN'), :Service => 'AWSECommerceService', :Operation => 'ItemLookup', :ResponseGroup => 'Offers'})
      # rs_price = item_price->get_hash('Amount')

      rs.push(product)
    end
    #item_price = Nokogiri::XML(item_price)
    ap item_price
    puts 'zzzz'
    ap rs
  end
end
