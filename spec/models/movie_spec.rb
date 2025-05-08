require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:restrict) }
    it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(5.0) }
    it { is_expected.to validate_presence_of(:director_name) }
    it { is_expected.to validate_numericality_of(:to_favorite_registered_count).only_integer.is_greater_than_or_equal_to(0) }

    context 'restrict only allows defined enum values' do
      it 'allows valid enum values' do
        Movie.restricts.keys.each do |key|
          expect { build(:movie, restrict: key) }.not_to raise_error
        end
      end

      it 'raises error for invalid enum value' do
        expect { build(:movie, restrict: :invalid) }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'scopes' do
    describe '.search' do
      shared_examples_for 'returns the correct number of movies' do |count|
        it { is_expected.to eq(count) }
      end

      subject { Movie.search(options: options).count }

      context 'when searching by title' do
        before do
          FactoryBot.create(:movie, title: 'The Great Adventure')
          FactoryBot.create(:movie, title: 'Mystery of the Lost City')
          FactoryBot.create(:movie, title: 'Journey to the Stars')
          FactoryBot.create(:movie, title: 'The Last Stand')
          FactoryBot.create(:movie, title: 'Secrets of the Deep')
          FactoryBot.create(:movie, title: 'Chronicles of the Forgotten')
          FactoryBot.create(:movie, title: 'Echoes of the Past')
          FactoryBot.create(:movie, title: 'Dawn of a New Era')
        end

        let(:options) { { title: title } }
        let(:title) { nil }

        context 'when no search conditions are specified' do
          it_behaves_like 'returns the correct number of movies', 8
        end

        context 'when the search condition is an empty string' do
          let(:title) { '' }

          it_behaves_like 'returns the correct number of movies', 8
        end

        context 'when search conditions are specified' do
          let(:title) { 'Echoes' }

          it_behaves_like 'returns the correct number of movies', 1
        end
      end

      context 'when searching by summary' do
        before do
          FactoryBot.create(:movie, summary: 'A thrilling adventure in the mountains.')
          FactoryBot.create(:movie, summary: 'A heartwarming story about friendship.')
          FactoryBot.create(:movie, summary: 'Mystery and suspense in a deserted town.')
          FactoryBot.create(:movie, summary: 'A sci-fi epic spanning galaxies.')
          FactoryBot.create(:movie, summary: 'Comedy about a dysfunctional family.')
          FactoryBot.create(:movie, summary: 'Romantic tale of love and loss.')
          FactoryBot.create(:movie, summary: 'Action-packed story of a hero\'s journey.')
          FactoryBot.create(:movie, summary: 'A historical drama set in ancient Rome.')
        end

        let(:options) { { summary: summary } }
        let(:summary) { nil }

        context 'when no search conditions are specified' do
          it_behaves_like 'returns the correct number of movies', 8
        end

        context 'when the search condition is an empty string' do
          let(:summary) { '' }

          it_behaves_like 'returns the correct number of movies', 8
        end

        context 'when search conditions are specified' do
          let(:summary) { 'story' }

          it_behaves_like 'returns the correct number of movies', 2
        end
      end

      context 'when searching by restrict' do
        before do
          FactoryBot.create(:movie, restrict: Movie.restricts[:general])
          FactoryBot.create(:movie, restrict: Movie.restricts[:pg_12])
          FactoryBot.create(:movie, restrict: Movie.restricts[:r_15])
          FactoryBot.create(:movie, restrict: Movie.restricts[:r_18])
          FactoryBot.create(:movie, restrict: Movie.restricts[:general])
          FactoryBot.create(:movie, restrict: Movie.restricts[:general])
          FactoryBot.create(:movie, restrict: Movie.restricts[:pg_12])
          FactoryBot.create(:movie, restrict: Movie.restricts[:r_15])
        end

        let(:options) { { restrict: restrict } }
        let(:restrict) { nil }

        context 'when no search conditions are specified' do
          it_behaves_like 'returns the correct number of movies', 8
        end

        context 'when search conditions are specified' do
          let(:restrict) { Movie.restricts[:general] }

          it_behaves_like 'returns the correct number of movies', 3
        end
      end

      context 'when searching by rating' do
        before do
          FactoryBot.create(:movie, rating: 0.0)
          FactoryBot.create(:movie, rating: 1.0)
          FactoryBot.create(:movie, rating: 1.5)
          FactoryBot.create(:movie, rating: 2.0)
          FactoryBot.create(:movie, rating: 2.5)
          FactoryBot.create(:movie, rating: 3.0)
          FactoryBot.create(:movie, rating: 3.5)
          FactoryBot.create(:movie, rating: 4.0)
        end

        let(:options) { { rating: rating } }
        let(:rating) { nil }

        context 'when no search conditions are specified' do
          it_behaves_like 'returns the correct number of movies', 8
        end

        context 'when search conditions are specified' do
          let(:rating) { 3 }

          it_behaves_like 'returns the correct number of movies', 3
        end
      end

      context 'when searching by favorite count' do
        before do
          FactoryBot.create_list(:movie, 3)
          FactoryBot.create(:movie, :with_favorites)
        end

        let(:options) { { to_favorite_registered_count: to_favorite_registered_count } }
        let(:to_favorite_registered_count) { nil }

        context 'when no search conditions are specified' do
          it_behaves_like 'returns the correct number of movies', 4
        end

        context 'when search conditions are specified' do
          let(:to_favorite_registered_count) { 1 }

          it_behaves_like 'returns the correct number of movies', 1
        end
      end

      context 'when no search conditions are specified' do
        before do
          FactoryBot.create(:movie, restrict: Movie.restricts[:general], rating: 0.0)
          FactoryBot.create(:movie, restrict: Movie.restricts[:pg_12], rating: 1.0)
          FactoryBot.create(:movie, restrict: Movie.restricts[:r_15], rating: 1.5)
          FactoryBot.create(:movie, restrict: Movie.restricts[:r_18], rating: 2.0)
          FactoryBot.create(:movie, restrict: Movie.restricts[:general], rating: 2.5)
          FactoryBot.create(:movie, restrict: Movie.restricts[:general], rating: 3.0)
          FactoryBot.create(:movie, restrict: Movie.restricts[:pg_12], rating: 3.5)
          FactoryBot.create(:movie, restrict: Movie.restricts[:r_15], rating: 4.0)
        end

        let(:options) { {} }
        it_behaves_like 'returns the correct number of movies', 8
      end

      context 'when multiple search conditions are specified' do
        before do
          FactoryBot.create(:movie, restrict: Movie.restricts[:general], rating: 0.0)
          FactoryBot.create(:movie, restrict: Movie.restricts[:pg_12], rating: 1.0)
          FactoryBot.create(:movie, restrict: Movie.restricts[:r_15], rating: 1.5)
          FactoryBot.create(:movie, restrict: Movie.restricts[:r_18], rating: 2.0)
          FactoryBot.create(:movie, restrict: Movie.restricts[:general], rating: 2.5)
          FactoryBot.create(:movie, restrict: Movie.restricts[:general], rating: 3.0)
          FactoryBot.create(:movie, restrict: Movie.restricts[:pg_12], rating: 3.5)
          FactoryBot.create(:movie, restrict: Movie.restricts[:r_15], rating: 4.0)
        end

        let(:options) do
          {
            restrict: Movie.restricts[:general],
            rating: 2.5
          }
        end

        it_behaves_like 'returns the correct number of movies', 2
      end
    end
  end
end
