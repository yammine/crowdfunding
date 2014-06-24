require 'rails_helper'

feature "Users", :type => :feature do
  describe "Registering a new account" do 

    it "register a user with valid information" do 
      visit root_path
      click_on "Sign Up"
      fill_in "First name", with: "Cheech"
      fill_in "Last name", with: "Chong"
      fill_in "Email", with: "cheechnchong@hotmail.com"
      fill_in "Password", with: "somevalidpassword123"
      fill_in "Password confirmation", with: "somevalidpassword123"
      click_button "Register"
      expect(current_path).to eq(root_path)
      expect(page).to have_text /Thanks for signing up/i
      expect(User.count).to eq(1)
    end

    it "doesn't register user with invalid email" do 
      visit root_path
      click_on "Sign Up"
      fill_in "First name", with: "Cheech"
      fill_in "Last name", with: "Chong"
      fill_in "Email", with: "cheechnchong@hotm"
      fill_in "Password", with: "somevalidpassword123"
      fill_in "Password confirmation", with: "somevalidpassword123"
      click_button "Register"
      save_and_open_page
      expect(current_path).to eq(users_path)
      ERROR_REGEX = /Couldn't create account/i
      expect(page).to have_content ERROR_REGEX
      expect(User.count).to eq(0)
    end
  end

  describe "authentication" do 
    let(:user) { create(:user) }

    it "authenticates user with proper credentials" do 
      visit root_path
      click_on "Sign In"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign In"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome!")
      expect(page).to have_content /#{user.full_name}/i
    end

  end
end
