require 'rails_helper'

feature "Campaigns", :type => :feature do

  let(:user) { create(:user) }

  describe "Listing Campaigns" do 
    it "displays welcome message" do 
      visit campaigns_path
      expect(page).to have_text "Welcome to Fund.sy"
    end

    it "displays page title" do 
      visit campaigns_path
      expect(page).to have_title "Crowdfunding"
    end

    context "with campaigns" do 
      let!(:campaign) { create(:campaign) }
      let!(:campaign1) { create(:campaign) }

      it "displays campaigns titles" do 
        visit campaigns_path
        expect(page).to have_text /#{campaign.title}/i
      end

      it "puts page titles in h2" do 
        visit campaigns_path
        expect(page).to have_selector("h2")
      end
    end
  end

  describe "Creating Campaigns" do 

    it "creates a campaign and redirect to campaign show page" do 
      login_via_web(user)
      visit new_campaign_path
      fill_in "Title", with: "Valid Campaign title"
      fill_in "Description", with: "valid description yo"
      fill_in "Target", with: 10000
      fill_in "End date", with: (Time.now + 10.days).strftime("%Y-%m-%d")
      click_button "Submit"
      expect(current_path).to eq(campaign_path(Campaign.last))
      expect(page).to have_content /Campaign successfully created./i
      expect(Campaign.count).to eq(1)
    end

  end

end
