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

puts 'Creating 10 fake User y Store...'

10.times do
  user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::IDNumber.valid)
  store = Store.new(
    name: Faker::Restaurant.name ,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number
  )
  store.user = user
  store.save!

  5.times do
    review = Review.new(rating: rand(1..5), comment: Faker::Company.catch_phrase, user_id: Store.last.user_id, store_id: rand(Store.first.id..Store.last.id))
    review.save!
  end
end




puts 'Finished!'