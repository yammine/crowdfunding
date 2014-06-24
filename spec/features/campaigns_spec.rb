require 'rails_helper'

feature "Campaigns", :type => :feature do
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

end
