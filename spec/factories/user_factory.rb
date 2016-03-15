FactoryGirl.define do
  factory :user do
    sequence(:name)   { |n| "Person_#{n}" }
    sequence(:email)  { |n| "person#{n}@example.com" }

    factory :user_with_api_key do
      after(:create) do |user|
        build(:api_key, user: user)
      end
    end
  end
end
