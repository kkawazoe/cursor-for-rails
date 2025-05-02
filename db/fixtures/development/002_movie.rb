require 'faker'

(1..30).each do |n|
  Movie.seed(
    :id,
    {
      id: n,
      title: Faker::Movie.unique.title,
      summary: Faker::Lorem.paragraph(
        sentence_count: 3,
        supplemental: true,
        random_sentences_to_add: 5
      ).truncate(255),
      restrict: Faker::Number.between(from: 0, to: 3),
      rating: Faker::Number.between(from: 0.0, to: 5.0).round(1),
      published_year: Faker::Number.between(from: 1900, to: 2023),
      director_name: Faker::Name.unique.name,
    }
  )
end
