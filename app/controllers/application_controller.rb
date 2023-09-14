class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def not_found
    render json: { error: 'not_found' }
  end

  def load_user_ability
    @current_ability = Ability.new(current_user)
  end

  def current_user
    token = request.headers['Authorization'].split(' ')[1]
    user_hash = JsonWebToken.decode(token)
    user_id = user_hash[:user_id]
    @current_user ||= User.find_by(id: user_id) if user_id
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
