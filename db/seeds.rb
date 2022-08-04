# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'Cleaning database 🧹'
Minion.destroy_all
User.destroy_all
puts 'Database clean ✨'

user = User.create!(username: "fake_user123", email: "fake@gmail.com", password: "iloveminions")

25.times do
  minion = Minion.create!(
    name: ['Bob', 'Carl', 'Darwin', 'Dave', 'Frank', 'Jerry', 'John', 'Kevin', 'ken', 'Lance', 'Larry', 'Mark', 'Mike',
           'Norbert', 'Paul', 'Phil', 'Steve', 'Stuart', 'Tim', 'Tom', 'Chris', 'mel', 'Jorge', 'Donny'].sample,
    skills: Faker::Games::Heroes.specialty,
    user_id: user.id,
    price_per_day: rand(150..10_000),
    photo: ['https://static.wikia.nocookie.net/despicableme/images/8/88/Carl_the_minion.jpg/revision/latest?cb=20130917134115', 'https://static.wikia.nocookie.net/despicableme/images/8/88/Tall.jpg/revision/latest/scale-to-width-down/185?cb=20220602225228'].sample
  )
  puts "Minion #{minion.id} created ✅"
end
