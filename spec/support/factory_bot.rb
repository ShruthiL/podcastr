require 'factory_bot'

FactoryBot.define do
  factory :user do
    first_name { "first name"}
    last_name { "last name"}
    sequence(:user_name) {|n| "user#{n}" }
    sequence(:email) {|n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end

end
