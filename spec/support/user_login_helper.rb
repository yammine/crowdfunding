module UserLoginHelper
  

  def login(user)
    request.session[:user_id] = user.id
  end

  def current_user
    User.find(request.sesssion[:user_id])
  end

  def login_via_web(user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end
end