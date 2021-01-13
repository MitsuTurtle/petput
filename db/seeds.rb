# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザー10名追加
# 10.times do |num|
#   user = User.new(nickname: Faker::Internet.username, email: Faker::Internet.free_email, password: "11111a", profile: Faker::Lorem.sentence(word_count: 15))
#   user.avatar.attach(io: File.open(Rails.root.join("app/assets/images/avatar/avatar#{num + 1}.jpeg")),filename: "avatar#{num + 1}.jpeg")
#   user.save
# end

# 写真追加
# カメ写真
22.times do |num|
  photo = Photo.new(caption: "#かめ #カメ #亀 #turtle\n\nカメちゃんです❗", category_id: 5, user_id: 31)
  photo.image.attach(io: File.open(Rails.root.join("app/assets/images/turtle#{num+1}.jpg")),filename: "turtle#{num+1}.jpg")
  photo.save
end

# 猫写真
# photo = Photo.new(caption: "#ねこ #ネコ #猫 #cat\n\n\n がんばって❗", category_id: 2, user_id: 34)
# photo.image.attach(io: File.open(Rails.root.join("app/assets/images/cat1.jpg")),filename: "cat1.jpg")
# photo.save
