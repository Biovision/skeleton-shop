class AuthenticationsController < ApplicationController
  before_action :redirect_authorized_user, only: [:new, :create]

  # get /login
  def new
  end

  # post /login
  def create
    user = User.find_by login: params[:login].to_s
    if user.is_a?(User) && user.authenticate(params[:password].to_s)
      authenticate_user user
    else
      invalid_credentials
    end
  end

  # delete /logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def redirect_authorized_user
    redirect_to root_path if current_user.is_a? User
  end

  def authenticate_user(user)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def invalid_credentials
    flash.now[:warning] = t(:invalid_credentials)
    render :new
  end
end
