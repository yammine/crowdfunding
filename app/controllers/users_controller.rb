class UsersController < ApplicationController

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Thanks for signing up"
    else
      flash.now[:alert] = "Couldn't create account"
      render :new
    end
  end



  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, 
                                :password, :password_confirmation, :avatar,
                                {profile_attributes: [:age, :address, :bio, :id]}
                                )
  end 

end
