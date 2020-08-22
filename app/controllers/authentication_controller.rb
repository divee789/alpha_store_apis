class AuthenticationController < ApplicationController
  # return auth token once user is authenticated
  def authenticate
    token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(access_token: token)
  end

  def authenticate_admin
    token = AuthenticateAdmin.new(auth_params[:email], auth_params[:password]).call
    json_response(access_token: token)
  end

  private

  def auth_params
    params.require(:authentication).permit(:email, :password)
  end
end
