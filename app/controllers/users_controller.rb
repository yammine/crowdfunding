class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Thanks for signing up"
    else
      flash.now[:alert] = "Couldn't create account"
      render :new
    end
  end



  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, 
                                :password, :password_confirmation)
  end 

end
