require 'faker'

User.destroy_all
Store.destroy_all
Product.destroy_all

users = []
stores = []

puts 'Creating fake Users'

users[1] = User.create(name: "Andrea", last_name: "Acevedo", email: "andrea@correo.cl", password: "123456", seller: true)
users[2] = User.create(name: "Pablo", last_name: "Martinez", email: "pablo@correo.cl", password: "123456", seller: true)
users[3] = User.create(name: "Marco", last_name: "Acevedo", email: "marco@correo.cl", password: "123456", seller: true)
users[4] = User.create(name: "Jorge", last_name: "Molina", email: "jorge@correo.cl", password: "123456", seller: true)
users[5] = User.create(name: "Juan", last_name: "Perez", email: "juan@correo.cl", password: "123456", seller: false)
users[6] = User.create(name: "Juana", last_name: "Soto", email: "juana@correo.cl", password: "123456", seller: false)

puts 'Creating fake stores'

stores[1] = Store.create(name: "Tiendita de Andrea",
    address: "Libertad 878",
    city: "Chillán",
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    user: users[1]
  )

stores[2] = Store.create(name: "Tiendita de Pablo",
    address: "Rosas 530",
    city: "Chillán",
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    user: users[2]
  )

stores[3] = Store.create(name: "Tiendita de Marco",
  address: "Constitución 444",
  city: "Chillán",
  email: Faker::Internet.email,
  phone: Faker::PhoneNumber.phone_number,
  user: users[3]
  )

stores[4] = Store.create(name: "Tiendita de Jorge",
    address: "Bulnes 739",
    city: "Chillán",
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    user: users[4]
  )


i = 1
while i <= 4

puts "Populating store #{i} products databases with fruits and vegetables"

  fruit_category = Category.create(name: "Frutas")
  10.times do
    fruits = Product.create(
      name: Faker::Food.fruits,
      old_price: Faker::Number.number(digits: 4),
      description: "Esto es una descripción de prueba",
      sku: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 2, min_numeric: 4),
      store: stores[i]
    )
  product_category = ProductCategory.create(category: fruit_category, product: fruits)
  end

  vegetables_category = Category.create(name: "Vegetales")
  10.times do
    vegetables = Product.create(
      name: Faker::Food.vegetables,
      old_price: Faker::Number.number(digits: 4),
      description: "Esto es una descripción de prueba",
      sku: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 2, min_numeric: 4),
      store: stores[i]
    )
  product_category = ProductCategory.create(category: vegetables_category, product: vegetables)
  end
  
  i += 1

end


puts "Generation of Review"

i = 1
while i <= 20

  5.times do
    review = Review.new(rating: rand(1..5), comment: Faker::Company.catch_phrase, user_id: users[rand(1..6)].id, store_id: stores[rand(1..4)].id)
    review.save!
  end

  i += 1

end

  
puts 'Finished'
