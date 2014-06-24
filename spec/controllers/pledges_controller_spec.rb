require 'rails_helper'

RSpec.describe PledgesController, :type => :controller do
  
  let(:user)     { create(:user)                }
  let(:campaign) { create(:campaign)}
  
  describe "#create" do

    context "with signed in user" do 

      before { login(user) }
      
      context "successful pledges" do 
        def successful_request
          post :create, campaign_id: campaign.id, pledge: {amount: 100}
        end

        it "adds a pledge associated with the campaign to the database" do 
          expect do
            successful_request
          end.to change { campaign.pledges.count }.by(1)
        end

        it "associates the created pledge with the logged in user" do 
          successful_request
          expect(Pledge.last.user).to eq(user)
        end

        it "redirects to the campaign show page" do 
          successful_request
          expect(response).to redirect_to campaign_path(campaign)
        end
      end

      context "unsuccesful pledge" do 
        
        def unsuccessful_pledge
          post :create, campaign_id: campaign.id, pledge: {amount: -20}
        end

        it "doesn't create a new record in the database" do 
          unsuccessful_pledge
          expect(campaign.pledges.count).to eq(0)
        end

        it "renders new template" do 
          unsuccessful_pledge
          expect(response).to render_template(:new)
        end

      end
    end

    context "with no signed in user" do 

      it "redirects to new session path" do 
        post :create, campaign_id: campaign.id
        expect(response).to redirect_to(new_session_path)
      end

    end
  end

  describe "#destroy" do 

  let!(:user)       { create(:user) }
  let!(:user1)      { create(:user) }
  let!(:campaign)   { create(:campaign) }
  let!(:pledge)     { create(:pledge, user: user, campaign: campaign) }

  def destroy_pledge
    delete :destroy, campaign_id: campaign.id, id: pledge.id
  end
  
    context "user logged in" do 

      before { login(user) }


      it "removes the pledge record from the database" do 
        expect do 
          destroy_pledge
        end.to change { Pledge.count }.by(-1)
      end

      it "doesn't let a user remove another user's pledge" do 
        login(user1)
        expect do 
          destroy_pledge
        end.to raise_error
      end

    end

    context "user not logged in" do 
      it "redirects to the log in page" do 
        destroy_pledge
        expect(response).to redirect_to(new_session_path)
      end
    end

  end


end
