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
    photo: ['https://static.wikia.nocookie.net/despicableme/images/8/88/Carl_the_minion.jpg/revision/latest?cb=20130917134115',
            'https://static.wikia.nocookie.net/despicableme/images/e/e5/One_eyed_spiky_minion.jpg/revision/latest/scale-to-width-down/149?cb=20220602225123',
            'https://static.wikia.nocookie.net/despicableme/images/e/ea/Short_plum.webp/revision/latest/scale-to-width-down/185?cb=20220602230937',
            'https://static.wikia.nocookie.net/despicableme/images/4/47/MTROG_Stuart.png/revision/latest/scale-to-width-down/185?cb=20220101205245',
            'https://static.wikia.nocookie.net/despicableme/images/d/d2/DM3_Dave_selfie.jpg/revision/latest/scale-to-width-down/185?cb=20170711184405',
            'https://static.wikia.nocookie.net/despicableme/images/8/88/Tall.jpg/revision/latest/scale-to-width-down/185?cb=20220602225228',
            'https://i.pinimg.com/736x/95/a1/95/95a195e665368324f79aeb0904e95d6d--happy-valentines-day-minions-quotes.jpg'].sample
  )
  puts "Minion #{minion.id} created ✅"
end
