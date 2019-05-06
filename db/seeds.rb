# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "password",
  password_confirmation: "password")

#ユーザー
99.times do |n|
name  = Faker::Name.name + "#{n}"
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end

#フレンド
user = User.find(1)
20.times do |n|
  other_user = User.find(n+2)
  other_user.friendships.create(request_id: user.id)
  print n
end