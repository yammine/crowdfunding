require 'rails_helper'

RSpec.describe Api::V1::CampaignsController, :type => :controller do

  render_views
  
  let(:campaign) { create(:campaign) }
  let(:api_key)  { create(:api_key)  }

  describe "#index" do 

    let!(:campaign1) { create(:campaign) }
    let!(:campaign2) { create(:campaign) }

    context "with api_key sent" do 
      before { get :index, format: :json, access_token: api_key.access_token }

      it { expect(response.body).to include(campaign1.title) }
      it { expect(response.body).to include(campaign2.title) }
    end

  end

  describe "#show" do 

    context "with api_key" do
      it "includes campaign's title" do 
        get :show, id: campaign.id, format: :json, access_token: api_key.access_token
        body_json = JSON.parse(response.body)
        expect(body_json["title"]).to eq(campaign.title)
      end
    end

    context "with no api key" do

      it "gives 401 http code" do 
        get :index, format: :json, id: campaign.id
        expect(response.status).to eq(401)
      end
    end


  end

end
