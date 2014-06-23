require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  let(:user) {create(:user)}

  describe "Logging In" do 
    
    context "successful login" do 

      def successful_login
        post :create, email: user.email,
                      password: user.password
      end

      it "allows authentication with valid email and password" do 
        successful_login
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to the home page" do 
        successful_login
        expect(response).to redirect_to(root_path)
      end

      it "sets flash message" do 
        successful_login
        expect(flash[:notice]).to be
      end
    end

    context "unsuccessful login" do
      def failed_login
        post :create, email: user.email,
                      password: user.password + "asdf"
      end

      it "doesn't allow authentication with invalid password" do 
        failed_login
        expect(session[:user_id]).to_not eq(user.id)
      end

      it "renders new template" do 
        failed_login
        expect(response).to render_template(:new)
      end

      it "sets flash message" do 
        failed_login
        expect(flash[:alert]).to be
      end

    end
  end

  describe "Logging Out" do
    
    def sign_out
      login(user)
      delete :destroy
    end

    it "clears the user_id from the session" do 
      sign_out
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the home page" do 
      sign_out
      expect(response).to redirect_to(root_path)
    end

    it "sets flash message" do 
      sign_out
      expect(flash[:notice]).to be
    end

  end

end
