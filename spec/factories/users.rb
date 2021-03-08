FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 10) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: rand(6..128), min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    profile { Faker::Lorem.characters(number: rand(1..160)) }
  end
end
