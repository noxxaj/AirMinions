# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "open-uri"

puts 'Cleaning database 🧹'
User.destroy_all
# Booking.destroy_all
# Minion.destroy_all
puts 'Database clean ✨'

User.create!(username: "fake_user123", email: "fake@gmail.com", password: "iloveminions")
User.create!(username: "minion_overlord", email: "notreal@gmail.com", password: "minionlover123")
User.create!(username: "minion_fan", email: "fake1@gmail.com", password: "minionfan")

names = ['Bob', 'Carl', 'Darwin', 'Dave', 'Frank', 'Jerry', 'John', 'Kevin', 'Ken', 'Lance', 'Larry', 'Mark', 'Mike',
  'Norbert', 'Paul', 'Phil', 'Steve', 'Stuart', 'Tim', 'Tom', 'Chris', 'Mel', 'Jorge', 'Donny']
# addresses = ['Piccadilly Circus', '11 Wall Street New York, NY', '221 B Baker St, London, England', 'Tour Eiffel Champ de Mars, Paris', 'Buckingham Palace, London, England']

names.each do |name|
  minion = Minion.new(
    name: name,
    skills: Faker::Games::Heroes.specialty,
    user_id: User.all.sample.id,
    price_per_day: rand(150..10_000),
    address: Faker::Address.full_address
  )
  file = URI.open("https://res.cloudinary.com/dqlkgz11b/image/upload/v1660241501/minions/#{name}.png")
  minion.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  minion.save!
  puts "Minion #{minion.name} created ✅"
end

# file_2 = URI.open('https://cdn11.bigcommerce.com/s-ydriczk/images/stencil/1280x1280/products/88251/90865/Prison-Minion-with-Bananas-cardboard-cutout-buy-now-at-Starsills__48033.1497885770.jpg')

# minion_two = Minion.new(
#   name: ['Bob', 'Carl', 'Darwin', 'Dave', 'Frank', 'Jerry', 'John', 'Kevin', 'ken', 'Lance', 'Larry', 'Mark', 'Mike',
#         'Norbert', 'Paul', 'Phil', 'Steve', 'Stuart', 'Tim', 'Tom', 'Chris', 'mel', 'Jorge', 'Donny'].sample,
#   skills: Faker::Games::Heroes.specialty,
#   user_id: User.first.id,
#   price_per_day: rand(150..10_000),
#   address: Faker::Address.street_address
# )
# minion_two.photo.attach(io: file_2, filename: 'nes_2.png', content_type: 'image/png')
# minion_two.save!
# puts "Minion #{minion.id} created ✅"



# 5.times do
#   minion = Minion.new(
#     name: ['Bob', 'Carl', 'Darwin', 'Dave', 'Frank', 'Jerry', 'John', 'Kevin', 'ken', 'Lance', 'Larry', 'Mark', 'Mike',
#            'Norbert', 'Paul', 'Phil', 'Steve', 'Stuart', 'Tim', 'Tom', 'Chris', 'mel', 'Jorge', 'Donny'].sample,
#     skills: Faker::Games::Heroes.specialty,
#     user_id: User.first.id,
#     price_per_day: rand(150..10_000),
#     address: Faker::Address.street_address
#   )
#   puts "Minion #{minion.id} created ✅"
# end

# Minion.all.each do |minion|
#   minion.photo.attach(io: URI.open(urls.sample), filename: 'minion image', content_type: 'image/jpeg')
# end

# Minion.all.each do |minion|
#   minion.save!
# end

3.times do
  minion = Minion.all.sample
  users = User.where("id != ?", minion.user)
  booking = Booking.create!(
    start_date: Faker::Date.between(from: '2022-01-01', to: '2022-03-01'),
    end_date: Faker::Date.between(from: '2022-03-02', to: '2022-07-01'),
    user_id: users.sample.id,
    minion_id: minion.id
  )
  puts "Booking #{booking.id} created ✅"
end
