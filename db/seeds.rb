# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'Cleaning database 🧹'
Booking.destroy_all
Minion.destroy_all
User.destroy_all
puts 'Database clean ✨'

User.create!(username: "fake_user123", email: "fake@gmail.com", password: "iloveminions")
User.create!(username: "minion_overlord", email: "notreal@gmail.com", password: "minionlover123")

25.times do
  minion = Minion.create!(
    name: ['Bob', 'Carl', 'Darwin', 'Dave', 'Frank', 'Jerry', 'John', 'Kevin', 'ken', 'Lance', 'Larry', 'Mark', 'Mike',
           'Norbert', 'Paul', 'Phil', 'Steve', 'Stuart', 'Tim', 'Tom', 'Chris', 'mel', 'Jorge', 'Donny'].sample,
    skills: Faker::Games::Heroes.specialty,
    user_id: User.first.id,
    price_per_day: rand(150..10_000),
    photo: 'https://i.pinimg.com/736x/95/a1/95/95a195e665368324f79aeb0904e95d6d--happy-valentines-day-minions-quotes.jpg',
    address: Faker::Address.street_address
  )
  puts "Minion #{minion.id} created ✅"
end

3.times do
  booking = Booking.create!(
    start_date: Faker::Date.between(from: '2022-01-01', to: '2022-03-01'),
    end_date: Faker::Date.between(from: '2022-03-02', to: '2022-07-01'),
    user_id: User.last.id,
    minion_id: (Minion.first.id..Minion.last.id).to_a.sample
  )
  puts "Booking #{booking.id} created ✅"
end
