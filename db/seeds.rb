# Settings
load_images = true

# Libraries
require 'faker'

#Load lists
require_relative 'lists'
fruit_list = $fruit_list
vegetable_list = $vegetable_list
description_list = $description_list
review_list = $review_list

# Metodos para facilitar el proceso
def filename(name)
  # Reemplaza letras con acentos y ñ
  filename = name.gsub('á','a').gsub('é','e').gsub('í','i').gsub('ó','o').gsub('ú','u').gsub('ñ','n').downcase
  return filename
end

# Agregar de Unsplash imagen por codigo y tamaño
def add_unplash_img(object, code, height, width)
  file = URI.open("https://source.unsplash.com/#{code}/#{height}x#{width}")
  object.photos.attach(io: file, filename: "3{code}.png", content_type: 'image/png')
end

# Agregar imagenes locales
def attach_images(product)
  list = []
  i = 1
  while i < 10
    this_filename = "./db/img_selection/#{filename(product.name)}#{i}.jpg"
    if File.exists?(this_filename)
      list << i
    end
    i += 1
  end

  list.shuffle!.first(rand(1..3)).each do |i|
    this_filename = "./db/img_selection/#{filename(product.name)}#{i}.jpg"
    if File.exists?(this_filename)
      file = open(this_filename)
      product.photos.attach(io: file, filename: "#{product.id}_#{i}.png", content_type: 'image/png')
    end
  end
end

def populate(store, list, category, descriptions, load_images)
  puts "Populating store #{store.id} with #{category.name}"
  list.shuffle!
  rand(8..15).times do |x|
    price = rand(50..250) * 10
    discount_price = rand(1..100) > 80 ? price * rand(70..95) / 100 : price
    discount = discount_price < price ? true : false
    featured = rand(1..100) > 80
    product = Product.new(
      name: list[x],
      price: price,
      discount_price: discount_price,
      discount: discount,
      description: descriptions[rand(0..descriptions.size-1)],
      active: true,
      sku: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 2, min_numeric: 4).upcase,
      store: store,
      featured: featured
    )
    if load_images
      attach_images(product)
    end
    product.save
    product_category = ProductCategory.create(category: category, product: product)
  end
end

# Delete previous seed
puts "Borrando registros de seed anterior"
User.destroy_all
Store.destroy_all
Product.destroy_all
Category.destroy_all
Review.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('stores')
ActiveRecord::Base.connection.reset_pk_sequence!('products')
ActiveRecord::Base.connection.reset_pk_sequence!('categories')
ActiveRecord::Base.connection.reset_pk_sequence!('reviews')

puts 'Creando usuarios'
users = []
users[1] = User.create(name: "Andrea", last_name: "Acevedo", email: "andrea@correo.cl", password: "123456", seller: true)
users[2] = User.create(name: "Pablo", last_name: "Martinez", email: "pablo@correo.cl", password: "123456", seller: true)
users[3] = User.create(name: "Marco", last_name: "Acevedo", email: "marco@correo.cl", password: "123456", seller: true)
users[4] = User.create(name: "Jorge", last_name: "Molina", email: "jorge@correo.cl", password: "123456", seller: true)
users[5] = User.create(name: "Juan", last_name: "Perez", email: "juan@correo.cl", password: "123456", seller: false)
users[6] = User.create(name: "Juana", last_name: "Soto", email: "juana@correo.cl", password: "123456", seller: false)

puts 'Creando tiendas'
stores = []
stores[1] = Store.create(name: "La tiendita de Andrea",
  address: "Libertad 878",
  city: "Chillán",
  email: "hablemos@latiendadeandrea.cl",
  phone: rand(912345678..992345678),
  user: users[1]
)
add_unplash_img(stores[1], "Ye7DTB1EeEY", 400, 400)

stores[2] = Store.create(name: "Verdulería Donde Pablo",
  address: "Rosas 530",
  city: "Chillán",
  email: "vegetable_listdondepablo@gmail.com",
  phone: rand(912345678..992345678),
  user: users[2]
)
add_unplash_img(stores[2], "ISPiuu_g6s8", 400, 400)

stores[3] = Store.create(name: "Minimarket de Marco",
  address: "Constitución 444",
  city: "Chillán",
  email: "contacto@minimarketdemarco.cl",
  phone: rand(912345678..992345678),
  user: users[3]
)
add_unplash_img(stores[3], "stpjHJGqZyw", 400, 400)

stores[4] = Store.create(name: "La huerta de Jorge",
  address: "Bulnes 739",
  city: "Chillán",
  email: "lahuertadejorge@gmail.com",
  phone: rand(912345678..992345678),
  user: users[4]
)
add_unplash_img(stores[4], "mOy3K9pixSk", 400, 400)

puts "Creando categorias"
frutas = Category.create(name: "Frutas")
verduras = Category.create(name: "Verduras")
infusiones = Category.create(name: "Infusiones")
mar = Category.create(name: "Productos de Mar")
congelados = Category.create(name: "Congelados")
organicos = Category.create(name: "Productos Orgánicos")
alcohol = Category.create(name: "Bebidas Alcohólicas")

puts "Cargando productos en tiendas"
populate(stores[1], fruit_list, frutas, description_list, load_images)
populate(stores[1], vegetable_list, verduras, description_list, load_images)
populate(stores[2], fruit_list, frutas, description_list, load_images)
populate(stores[2], vegetable_list, verduras, description_list, load_images)
populate(stores[3], fruit_list, frutas, description_list, load_images)
populate(stores[3], vegetable_list, verduras, description_list, load_images)
populate(stores[4], fruit_list, frutas, description_list, load_images)
populate(stores[4], vegetable_list, verduras, description_list, load_images)

puts "Cargando reseñas"
l = 1
while l <= 4
  review_list.shuffle
  rand(3..10).times do |m|
    review = Review.new(rating: rand(4..5), comment: review_list[m], user_id: users[rand(1..6)].id, store_id: stores[l].id, created_at: Faker::Time.backward(days: 90))
    review.save!
  end
l += 1
end
  
puts 'Proceso completado'
