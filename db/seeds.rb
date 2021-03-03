# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CATEGORIES = %w(패션 뷰티 유아동 식품 주방용품 생활용품 인테리어 가전 스포츠 자동차 여행 도서 완구 문구 반려동물 건강식품)


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

[User, Category, Item].each do |cls|
  GenerateSeed.exec(cls)
end