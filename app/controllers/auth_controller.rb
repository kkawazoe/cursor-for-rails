class AuthController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new.serialize(user), status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def sign_in
    if params[:email].blank? || params[:password].blank?
      return render json: { errors: [ I18n.t("api.auth.sign_in.missing_credentials") ] }, status: :bad_request
    end

    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_token(user)
      render json: AuthSerializer.new.serialize({ user: user, token: token }), status: :ok
    else
      render json: { errors: [ I18n.t("api.auth.sign_in.invalid_credentials") ] }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def generate_token(user)
    payload = { user_id: user.id, exp: expiration_time.to_i }
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def expiration_time
    ENV.fetch("JWT_EXPIRATION_HOURS", 24).to_i.hours.from_now
  end
end
