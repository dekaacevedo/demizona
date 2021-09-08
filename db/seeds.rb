require 'faker'
load_images = false

User.destroy_all
Store.destroy_all
Product.destroy_all
Category.destroy_all
Review.destroy_all

users = []
stores = []

puts 'Creating fake users'
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
    phone: rand(912345678..992345678),
    user: users[1]
  )
stores[2] = Store.create(name: "Tiendita de Pablo",
    address: "Rosas 530",
    city: "Chillán",
    email: Faker::Internet.email,
    phone: rand(912345678..992345678),
    user: users[2]
  )
stores[3] = Store.create(name: "Tiendita de Marco",
  address: "Constitución 444",
  city: "Chillán",
  email: Faker::Internet.email,
  phone: rand(912345678..992345678),
  user: users[3]
  )
stores[4] = Store.create(name: "Tiendita de Jorge",
    address: "Bulnes 739",
    city: "Chillán",
    email: Faker::Internet.email,
    phone: rand(912345678..992345678),
    user: users[4]
  )

puts "Creating categories"
fruit_category = Category.create(name: "Frutas")
vegetables_category = Category.create(name: "Vegetales")
infusiones = Category.create(name: "Infusiones")
mar = Category.create(name: "Productos de Mar")
congelados = Category.create(name: "Congelados")
organicos = Category.create(name: "Productos Orgánicos")
alcohol = Category.create(name: "Bebidas Alcohólicas")

puts "Populating stores with fruits and vegetables"
i = 1
while i <= 4
  rand(8..15).times do
    price = rand(50..250) * 10
    discount_price = rand(1..100) > 80 ? price * rand(70..95) / 100 : price
    discount = discount_price < price ? true : false
    fruits = Product.new(
      name: Faker::Food.fruits,
      price: price,
      discount_price: discount_price,
      discount: discount,
      description: Faker::Lorem.sentence(word_count: 4, supplemental: true, random_words_to_add: 10),
      active: true,
      sku: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 2, min_numeric: 4).upcase,
      store: stores[i]
    )
    if load_images
      file = URI.open("https://source.unsplash.com/featured/400x300/?#{fruits.name},fruits")
      fruits.photos.attach(io: file, filename: "#{fruits.id}.png", content_type: 'image/png')
    end
    fruits.save
    product_category = ProductCategory.create(category: fruit_category, product: fruits)
  end
  rand(8..15).times do
    price = rand(50..250) * 10
    discount_price = rand(1..100) > 80 ? price * rand(70..95) / 100 : price
    discount = discount_price < price ? true : false
    vegetables = Product.new(
      name: Faker::Food.vegetables,
      price: price,
      discount_price: discount_price,
      discount: discount,
      description: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
      active: true,
      sku: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 2, min_numeric: 4).upcase,
      store: stores[i]
    )
    if load_images
      file = URI.open("https://source.unsplash.com/featured/400x300/?#{vegetables.name},vegetables")
      vegetables.photos.attach(io: file, filename: "#{vegetables.id}.png", content_type: 'image/png')
    end
    vegetables.save
    product_category = ProductCategory.create(category: vegetables_category, product: vegetables)
  end
  i += 1
end

puts "Creating fake reviews"
i = 1
while i <= 20
  5.times do
    review = Review.new(rating: rand(1..5), comment: Faker::Company.catch_phrase, user_id: users[rand(1..6)].id, store_id: stores[rand(1..4)].id)
    review.save!
  end
  i += 1
end
  
puts 'Finished'
