# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create! name: "Long story"

30.times do |n|
  title = "Toi thay hoa vang tren co xanh"
  picture = "https://vcdn.tikicdn.com/cache/w232/media/catalog/product/t/o/toi_thay_hoa_vang.jpg"
  publish_date = "09/12/2010"
  author = "Nguyen Nhat Anh"
  number_of_page = 150
  category_id = 1
  Book.create! title: title, picture: picture, publish_date: publish_date,
    author: author, number_of_page: number_of_page, category_id: category_id
end

User.create! name: "Linh", email: "linh@framgia.com",
  phone_number: "1111111111", gender: "female", password: "111111",
  password_confirmation: "111111", is_admin: true

25.times do |n|
  name = "ABC#{n}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, phone_number: "1111111111",
    gender: "male", password: password, password_confirmation: password
end
