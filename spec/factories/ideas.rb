FactoryBot.define do
  factory :idea do
    sequence(:title) { |n| Faker::Lorem.sentence + " #{n}" }
    description { Faker::Lorem.sentences }
    association(:user, factory: :user)

  end
end
