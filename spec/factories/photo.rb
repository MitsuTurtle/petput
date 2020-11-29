FactoryBot.define do
  factory :photo do
    caption              { Faker::Lorem.sentence }
    category_id          { Faker::Number.within(range: 1..10) }

    association :user

  end
end