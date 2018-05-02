FactoryBot.define do
  factory :order_detail do
    quantity 1
    total 1000
    product Product.create({title: 'Product', description: 'Product description', price: 2000, picture: 'abc.png', item_code: '01'})
  end
end