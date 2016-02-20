FactoryGirl.define do
  factory :code_snippet do
    association :user, factory: :user
    association :language, factory: :language

    title         { Faker::Company.bs }
    body          { Faker::Lorem.paragraph }
    privacy       false
  end
end
