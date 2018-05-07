class HomeController < ApplicationController
  def index
    @page_title = 'Home'
    @categories =  Category.includes(:product).all
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
end
