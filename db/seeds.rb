# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create! name: "Long story"
Category.create! name: "Tham khao"

30.times do |n|
  title = "Toi thay hoa vang tren co xanh"
  picture = "https://vcdn.tikicdn.com/cache/w232/media/catalog/product/t/o/toi_thay_hoa_vang.jpg"
  publish_date = "09/12/2010"
  author = "Nguyen Nhat Anh"
  number_of_page = 150
  category_id = 1
  quantity_favorite = 0
  Book.create! title: title, picture: picture, publish_date: publish_date,
    author: author, number_of_page: number_of_page, category_id: category_id,
    quantity_favorite: quantity_favorite
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

5.times do |n|
  title = "1001 cach lam giau"
  picture = "http://bookbuy.vn/Res/Images/Product/1001-cach-lam-giau_31813_1.png"
  publish_date = "10/12/2010"
  author = "Quoc Khanh - Thu Minh"
  number_of_page = 150
  category_id = 2
  avg_rate = 5
  Book.create! title: title, picture: picture, publish_date: publish_date,
    author: author, number_of_page: number_of_page, category_id: category_id,
    avg_rate: avg_rate
end
