FactoryBot.define do
  factory :product do
  	item_code "01"
  	picture "abc.png"
    title "Product title"
    description "Product description"
    price 299.99
    category Category.create({title: 'Category', description: 'Category description'})
  end
end