require 'rails_helper'

RSpec.describe CampaignsController, :type => :controller do

  let(:campaign) { create(:campaign) }

  describe "#index" do 
    it "includes campaigns created" do 
      campaign
      campaign1 = create(:campaign)
      get :index
      expect(assigns(:campaigns)).to include(campaign1)
    end

    it "renders index template" do 
      get :index
      expect(response).to render_template(:index)
    end

    it "only selects 10 campaigns" do 
      20.times { create(:campaign) }
      get :index
      expect(assigns(:campaigns).count).to be <= 10
    end
  end

  describe "#new" do 

    it "assigns a new campaign variable" do 
      get :new
      expect(assigns(:campaign)).to be_a_new(Campaign)
    end

    it "renders a new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do 
    context "with valid request" do 
      def valid_request
        post :create, campaign: { title: "My First Campaign", 
                                  description: "My First Campaign",
                                  end_date: Time.now + 10.days, 
                                  target: 5000 }
      end

      it "creates a new record in the database" do 
        expect{ valid_request }.to change{Campaign.count}.by(1)
      end

      it "redirects to the campaign show page" do 
        valid_request
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end

      it "sets flash message" do 
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid request" do 
      def invalid_request
        post :create, campaign: { title: "asdf" }
      end
      
      it "does not create a record in the database" do 
        expect{ invalid_request }.to_not change { Campaign.count }
      end

      it "renders new template" do 
        invalid_request
        expect(response).to render_template(:new)
      end

    end
  end

  describe "#show" do 

    it "assigns a campaign instance variable with a passed id" do 
      get :show, id: campaign.id
      expect(assigns(:campaign)).to eq(campaign)
    end

    it "renders show template" do 
      get :show, id: campaign.id
      expect(response).to render_template(:show)
    end

    it "raises an error if trying to acces non-existing campaign" do 
      expect { get :show, id: (campaign.id +1) }.to raise_error 
    end
  end

  describe "#edit" do 

    it "sets a campaign instance variable with an id" do 
      get :edit, id: campaign.id
      expect(assigns(:campaign)).to eq campaign
    end

    it "renders edit template" do 
      get :edit, id: campaign.id
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do 

    context "successful update" do 
      it "updates the campaign record with a new title" do 
        patch :update, id: campaign.id, campaign: {title: "updated title"}
        campaign.reload
        expect(campaign.title).to match /updated title/i
      end

      it "redirects to the campaign show page" do 
        patch :update, id: campaign.id, campaign: {title: "updated title"}
        expect(response).to redirect_to(campaign)
      end

      it "sets flash message" do 
        patch :update, id: campaign.id, campaign: {title: "updated title"}
        expect(flash[:notice]).to be
      end
    end
    context "failed update" do 
      it "doesn't update the campaign title to empty" do 
        patch :update, id: campaign.id, campaign: {title: ""}
        campaign.reload
        expect(campaign.title).to_not eq("")
      end

      it "renders edit template" do 
        patch :update, id: campaign.id, campaign: {title: ""}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do 
    it "removes the campaign record from the database" do 
      campaign
      expect{delete :destroy, id: campaign.id }.to change { Campaign.count }.by(-1)
    end

    it "redirects to the campaigns index" do 
      delete :destroy, id: campaign.id 
      expect(response).to redirect_to(campaigns_path)
    end

    it "sets a flash notice" do 
      delete :destroy, id: campaign.id
      expect(flash[:notice]).to be
    end
  end

end
