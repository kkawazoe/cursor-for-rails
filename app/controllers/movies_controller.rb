class MoviesController < ApplicationController
  def index
    render json: Panko::ArraySerializer.new(
      Movie.search(options: search_params[:search] || {}),
      each_serializer: Movies::ListSerializer
    ).to_json
  end

  private

  def search_params
    params.permit(
      search: [
        :title,
        :summary,
        :restrict,
        :rating,
        :to_favorite_registered_count
      ]
    )
  end
end
