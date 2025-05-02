FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }

    trait :invalid_email do
      email { "invalid_email" }
    end

    trait :short_password do
      password { "short" }
      password_confirmation { "short" }
    end
  end
end
