require 'rails_helper'

RSpec.describe User, type: :model do

  describe ".full_name" do 

    it "gives concatenated first name and last name if provided" do 
      user = User.new(first_name: "Chris", last_name: "Yammine")
      expect(user.full_name).to eq("Chris Yammine")
    end

    it "give email if first name or last name are missing" do 
      user = User.new(email: "chris@hotmail.com")
      expect(user.full_name).to eq("chris@hotmail.com")
    end

    it "gives first name if first name is provided" do 
      user = User.new(first_name: "Chris", email: "chris@hotmail.com")
      expect(user.full_name).to eq("Chris")
    end
  end

  describe "Validations" do 
    
    describe "email validations" do 
      
      it "is invalid without an email" do 
        user = User.new(first_name: "Chris", last_name: "Yammine")
        expect(user).to be_invalid
      end
      
      it "is invalid with an improperly formatted email address" do 
        user = User.new(email: "asdfasdf")
        user.save
        expect(user.errors.messages).to have_key(:email)
      end


    end
  end

  describe "Callbacks" do 
    it "capitalizes first name before save" do 
      user = User.new(first_name: "tam", email: "tam@codecore.ca", 
                      password: "abcd1234", password_confirmation: "abcd1234")
      user.save
      expect(user.first_name).to eq("Tam")
    end
  end

  describe "Hashing password" do 
    it "generates password digest from password" do 
      user = User.new(email: "chris@codecore.ca", 
                      password: "abcd1234", password_confirmation: "abcd1234")
      user.save
      expect(user.password_digest).to be
    end
  end

end
