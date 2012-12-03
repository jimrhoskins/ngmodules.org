class SessionController < ApplicationController
  skip_authorization_check

  def new
    session[:redirect_to] = params[:redirect_to] if params[:redirect_to]
    redirect_to "/auth/github"
  end

  def create
    user = User.find_or_create_by_oauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to session.delete( :redirect_to ) || root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to params[:redirect_to] || root_path
  end
end

