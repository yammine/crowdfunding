class SessionsController < ApplicationController

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome!"
    else
      flash.now[:alert] = "The email or password you entered is incorrect."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out. See you next time!"
  end

end
