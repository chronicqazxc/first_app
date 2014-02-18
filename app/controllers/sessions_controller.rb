class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [ :new, :create ]
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      # Sign in
      sign_in(@user) #helper
      flash[:success] = "Welcome back, #{@user.name}!"
      redirect_to @user
    else
      flash.now[:warning] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
