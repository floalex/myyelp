class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]
  
  def new
    redirect_to home_path if current_user
  end
  
  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      signin_users!(user)
    else
      flash[:danger] = 'Incorrect email or password.'
      redirect_to sign_in_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have signed out.'
    redirect_to home_path
  end
  
  private
  
  def signin_users!(user)
    session[:user_id] = user.id
    flash[:success] = "Welcome, you are signed in."
    redirect_to home_path
  end
end