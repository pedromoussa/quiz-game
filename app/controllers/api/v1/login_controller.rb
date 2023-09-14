class Api::V1::LoginController < ApplicationController
  before_action :authorize_request, except: :login
  protect_from_forgery

  def login

    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      # render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
      #                username: @user.username }, status: :ok
      render json: { token: token }, status: 200
    else
      render json: { error: 'unauthorized' }, status: 401
    end
  end

  private

  def login_params
    params.permit(:username, :password)
  end

end
