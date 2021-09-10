require 'faker'
load_images = true

frutas = %w[Arándano Cereza Chirimoya Ciruela Coco Frambuesa Frutilla Grosella Mandarina Mango Manzana Mora Naranja Pera Banana Pomelo Uva Almendra Nueces]

verduras = %w[Acelga Ají Alcachofa Brócoli Calabacín Calabaza Cebolla Espinaca Guisante Jengibre Lechuga Maíz Pepino Perejil Pimiento Puerro Rábano Remolacha Tomate Yuca Zanahoria Zapallo Limón]

descripciones_frutas = ["Sabroso fruto, conocido y apetecido por muchos", "Directo desde el huerto a su mesa, siempre fresco y apetitoso", "Infaltable en sus preparaciones, siempre encontrará este producto con calidad de exportación en nuestra tienda", "Uno de nuestros nuevos productos, que destaca por su frescura y calidad", "Con sello local, producto 100% de agricultores de la zona", "Producidos de manera 100% organica"]
descripciones_verduras = ["Directo desde el huerto a su mesa, siempre frescas y apetitosas", "Infaltable en sus preparaciones, por eso siempre la encontrará en nuestra tienda", "Nuestro producto estrella, siempre fresca y con la mejor calidad", "Uno de nuestros nuevos productos, que destaca por su frescura y calidad", "Con sello local, producto 100% de agricultores de la zona", "Producto organico, fresco y envasado en empaque reciclable"]

resenas = ["Excelentes productos", "Buena atención y variedad", "Excelente ubicación y atención del personal", "El servicio de despacho es muy bueno", "Buenos precios y calidad", "Excelentes ofertas los días lunes", "Mi tienda favorita", "La recomiendo totalmente", "Si quieres encontrar productos de calidad este es tu lugar","Frutas frescas y variadas", "Bonita tienda y bien variada", "Muy amables para atender", "Local amplio y bonito", "Productos de la zona siempre frescos", "Se puede comprar con despacho a domicilio, buena opción", "Gran variedad", "Siempre encuentro lo que busco en este lugar"]

User.destroy_all
Store.destroy_all
Product.destroy_all
Category.destroy_all
Review.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('categories')
ActiveRecord::Base.connection.reset_pk_sequence!('stores')
ActiveRecord::Base.connection.reset_pk_sequence!('products')

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
stores[1] = Store.create(name: "La tiendita de Andrea",
  address: "Libertad 878",
  city: "Chillán",
  email: "hablemos@latiendadeandrea.cl",
  phone: rand(912345678..992345678),
  user: users[1]
)
file = URI.open("https://source.unsplash.com/Ye7DTB1EeEY/400x400")
stores[1].photos.attach(io: file, filename: "store.png", content_type: 'image/png')

stores[2] = Store.create(name: "Verdulería Donde Pablo",
  address: "Rosas 530",
  city: "Chillán",
  email: "verdurasdondepablo@gmail.com",
  phone: rand(912345678..992345678),
  user: users[2]
)
file = URI.open("https://source.unsplash.com/ISPiuu_g6s8/400x400")
stores[2].photos.attach(io: file, filename: "store.png", content_type: 'image/png')

stores[3] = Store.create(name: "Minimarket de Marco",
  address: "Constitución 444",
  city: "Chillán",
  email: "contacto@minimarketdemarco.cl",
  phone: rand(912345678..992345678),
  user: users[3]
  )
file = URI.open("https://source.unsplash.com/stpjHJGqZyw/400x400")
stores[3].photos.attach(io: file, filename: "store.png", content_type: 'image/png')

stores[4] = Store.create(name: "La huerta de Jorge",
  address: "Bulnes 739",
  city: "Chillán",
  email: "lahuertadejorge@gmail.com",
  phone: rand(912345678..992345678),
  user: users[4]
)
file = URI.open("https://source.unsplash.com/mOy3K9pixSk/400x400")
stores[4].photos.attach(io: file, filename: "store.png", content_type: 'image/png')

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
  fruits_list = frutas.shuffle
  vegetables_list = verduras.shuffle
  rand(8..15).times do |j|
    price = rand(50..250) * 10
    discount_price = rand(1..100) > 80 ? price * rand(70..95) / 100 : price
    discount = discount_price < price ? true : false
    fruits = Product.new(
      name: fruits_list[j],
      price: price,
      discount_price: discount_price,
      discount: discount,
      description: descripciones_frutas[rand(0..descripciones_frutas.size-1)],
      active: true,
      sku: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 2, min_numeric: 4).upcase,
      store: stores[i]
    )
    if load_images
      file = URI.open("https://source.unsplash.com/300x300/?#{ERB::Util.url_encode(fruits.name)}s")
      unless file.base_uri.to_s.include?("404")
        fruits.photos.attach(io: file, filename: "#{fruits.id}.png", content_type: 'image/png')
      end
    end
    fruits.save
    product_category = ProductCategory.create(category: fruit_category, product: fruits)
  end
  rand(8..15).times do |k|
    price = rand(50..250) * 10
    discount_price = rand(1..100) > 80 ? price * rand(70..95) / 100 : price
    discount = discount_price < price ? true : false
    vegetables = Product.new(
      name: vegetables_list[k],
      price: price,
      discount_price: discount_price,
      discount: discount,
      description: descripciones_verduras[rand(0..descripciones_verduras.size-1)],
      active: true,
      sku: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 2, min_numeric: 4).upcase,
      store: stores[i]
    )
    if load_images
      file = URI.open("https://source.unsplash.com/400x300/?#{ERB::Util.url_encode(vegetables.name)}s")
      unless file.base_uri.to_s.include?("404")
        vegetables.photos.attach(io: file, filename: "#{vegetables.id}.png", content_type: 'image/png')
      end
    end
    vegetables.save
    product_category = ProductCategory.create(category: vegetables_category, product: vegetables)
  end
  i += 1
end

puts "Creating fake reviews"
l = 1
while l <= 4
  resenas.shuffle
  rand(3..10).times do |m|
    review = Review.new(rating: rand(3..5), comment: resenas[m], user_id: users[rand(1..6)].id, store_id: stores[l].id, created_at: Faker::Time.backward(days: 90))
    review.save!
  end
l += 1
end
  
puts 'Finished'
