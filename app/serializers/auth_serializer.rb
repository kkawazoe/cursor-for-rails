class AuthSerializer < Panko::Serializer
  attributes :user, :token

  def user
    UserSerializer.new.serialize(object[:user])
  end

  def token
    object[:token]
  end
end
