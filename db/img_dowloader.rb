require "open-uri"
require 'erb'
require 'json'
# require 'curl'

require_relative 'lists'
fruit_list = $fruit_list
vegetable_list = $vegetable_list

def filename(name)
  # Reemplaza letras con acentos y ñ
  name.gsub!('á','a')
  name.gsub!('é','e')
  name.gsub!('í','i')
  name.gsub!('ó','o')
  name.gsub!('ú','u')
  name.gsub!('ñ','n')
  name.downcase!
  return name
end

def empty_folder
  puts "Borrando archivos anteriores"
  lista = Dir["./db/img_download/*"]
  lista.each do |img_file|
    if File.exists?(img_file)
      File.delete(img_file)
    end
  end
end

def save_image(product, url)
  # Crear ruta de archivo
  i = 1
  filename_found = false
  until filename_found == true
    if File.exists? "./db/img_download/#{filename(product)}#{i}.jpg"
      i += 1
    else
      this_filename = "./db/img_download/#{filename(product)}#{i}.jpg"
      filename_found = true
    end    
  end

  # Guardar imagen
  open(url) do |image|
    File.open(this_filename, "wb") do |file|
      file.write(image.read)
      # puts "Imagen #{product} ##{i} creada"
    end
  end
end

# Descargamos la lista de imagenes del array entregado
def download_from_unsplash(list)
  list.each do |product|
    # Generamos url de imagen
    url = "https://source.unsplash.com/featured/300x300/?#{ERB::Util.url_encode(product)}"
    # Descargamos y guardamos imagen
    puts "Descargado 1 imagen de #{product} desde Pixabay"
    save_image(product, url)
  end
end

# Descargamos la lista de imagenes del array entregado
def download_from_pixabay(list, num)
  puts "Descargando #{num} imagenes por producto desde Pixabay"
  puts "******************************************************"
  list.each do |product|
    puts "Descargado imagenes de #{product}"
    results_url = "https://pixabay.com/api/?lang=es&category=food&colors=white&key=1343716-99a010626f84d2fbcb5c78bda&q=#{ERB::Util.url_encode(product)}&image_type=photo"
    results_serialized = URI.open(results_url).read
    results = JSON.parse(results_serialized)
    images = results["hits"]
    images.first(num).each do |image|
      url = image["largeImageURL"]
      save_image(product, url)
    end
  end
end

# Descargamos archivos
empty_folder
#download_from_pixabay(fruit_list, 10)
#download_from_pixabay(vegetable_list, 10)
download_from_unsplash(fruit_list)
download_from_unsplash(vegetable_list)
