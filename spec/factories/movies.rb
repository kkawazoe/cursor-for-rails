FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Movie Title #{n}" }
    summary { Faker::Lorem.paragraph }
    restrict { Movie.restricts[:general] }
    rating { Faker::Number.between(from: 0.0, to: 5.0).round(1) }
    published_year { Faker::Number.between(from: 1980, to: 2024) }
    director_name { Faker::Name.name }

    trait :pg_12 do
      restrict { Movie.restricts[:pg_12] }
    end

    trait :r_15 do
      restrict { Movie.restricts[:pg_15] }
    end

    trait :r_18 do
      restrict { Movie.restricts[:r_18] }
    end

    trait :with_favorites do
      to_favorite_registered_count { 3 }
    end
  end
end
