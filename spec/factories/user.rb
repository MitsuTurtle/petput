FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 5) }
    email                 { Faker::Internet.free_email }
    password              { "#{Faker::Internet.password(min_length: 4)}1a" }
    password_confirmation { password }
  end
end
