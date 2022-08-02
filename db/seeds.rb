# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(username: "fake_user123", email: "fake@gmail.com", password: "iloveminions")

5.times do
  Minion.create!(name: "Fred", skills: "Digging", user_id: 1, price_per_day: 10_000)
end
