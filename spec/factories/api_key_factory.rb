require 'bcrypt'

FactoryGirl.define do
  factory :api_key do
    user            { build(:user) }
    sequence(:name) { |n| "key_#{n}" }
    identifier      { SecureRandom.urlsafe_base64(15, false) }
    password_hash   { SecureRandom.urlsafe_base64(30, false) }
  end
end
