FactoryBot.define do
  factory :order do
  	email "test@mail.com"
  	phone "0123456789"
    address "123 My Address"
    description "My Description"
    total 1000.01
  end
end