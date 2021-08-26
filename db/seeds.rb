# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
Store.destroy_all
Product.destroy_all

puts 'Creating 2 fake Users, 1 fake Store and 10 fake Products each'

user1 = User.create(name: "Andrea", last_name: "Acevedo", email: "andrea@correo.cl", password: "123456", seller: true)
store1 = Store.create(name: "Tiendita de Andrea",
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    user: user1
  )

user2 = User.create(name: "Pablo", last_name: "Martinez", email: "pablo@correo.cl", password: "123456", seller: true)
store2 = Store.create(name: "Tiendita de Pablo",
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    user: user2
    )
    5.times do
      review = Review.new(rating: rand(1..5), comment: Faker::Company.catch_phrase, user_id: Store.last.user_id, store_id: rand(Store.first.id..Store.last.id))
      review.save!
    end
  

fruit_category = Category.create(name: "Frutas")
vegetables_category = Category.create(name: "Vegetales")

10.times do
  fruits = Product.create(
    name: Faker::Food.fruits,
    old_price: Faker::Number.number(digits: 4),
    description: "Esto es una descripción de prueba",
    sku: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 2, min_numeric: 4),
    store: store1
  )

  product_category = ProductCategory.create(category: fruit_category, product: fruits)

  puts 'Finished!'

end

10.times do
  vegetables = Product.create(
    name: Faker::Food.vegetables,
    old_price: Faker::Number.number(digits: 4),
    description: "Esto es una descripción de prueba",
    sku: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 2, min_numeric: 4),
    store: store2
  )

  product_category = ProductCategory.create(category: vegetables_category, product: vegetables)

  puts 'Finished!'
end
