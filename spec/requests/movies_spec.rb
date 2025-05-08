require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  let!(:movie) do
    FactoryBot.create(
      :movie,
      title: 'Summer Adventure',
      summary: 'A story about a young boy who gets caught up in mysterious events during his family vacation at a seaside town.',
      restrict: 0,
      rating: 4.5,
      published_year: 2023,
      director_name: 'John Smith',
      to_favorite_registered_count: 3
    )
  end
  let(:response_body) { JSON.parse(response.body, symbolize_names: true) }

  describe 'GET /movies (#index)' do
    before do
      get movies_path
    end

    it 'returns status code success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns correct response' do
      expect(response_body).to eq(
        [
          {
            id: movie.id,
            title: 'Summer Adventure',
            summary: 'A story about a young boy who gets caught up in mysterious events during his family vacation at a seaside town.',
            restrict: 0,
            rating: 4.5,
            to_favorite_registered_count: 3
          }
        ]
      )
    end
  end
end
