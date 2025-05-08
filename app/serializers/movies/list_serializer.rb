module Movies
  class ListSerializer < Panko::Serializer
    attributes :id, :title, :summary, :restrict, :rating, :to_favorite_registered_count

    def restrict
      object.restrict_before_type_cast
    end
  end
end
