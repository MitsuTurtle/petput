FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentences }
    
    association :user
    association :photo
  end
end
