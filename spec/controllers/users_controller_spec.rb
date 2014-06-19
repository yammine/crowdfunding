require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "#new" do 
    it "assigns a new user variable" do 
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders a new template" do 
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do 

    context "with a valid request" do 

      def valid_request
        post :create, user: {first_name: "chris", last_name: "Yammine",
                              email: "chris@codecore.ca", password: "abcd1234", 
                              password_confirmation: "abcd1234"}
      end

      it "creates a user record in the database" do 
        expect { valid_request }.to change { User.count }.by(1)
      end

      it "redirects to home page" do 
        valid_request
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash notice messsage" do 
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid request" do 
      def invalid_request
        post :create, user: {first_name: "abc"}
      end

      it "doesn't change the number of users in the database" do 
        expect { invalid_request }.to_not change { User.count }
      end

      it "renders the new template" do 
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets the alert flash message" do 
        invalid_request
        expect(flash[:alert]).to be
      end

    end

  end


end
