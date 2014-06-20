require 'rails_helper'

RSpec.describe Campaign, :type => :model do
  describe "validations" do 
    it "includes a title" do 
      campaign = Campaign.new
      expect(campaign).to be_invalid
    end

    it "includes a description" do 
      campaign = Campaign.new(title: "asdf")
      expect(campaign).to be_invalid
    end

    it "includes an end date" do 
      campaign = Campaign.new(title: "asdf", description: "asdfasdfasdf")
      expect(campaign).to be_invalid
    end

    it "includes a target" do 
      campaign = Campaign.new(title: "asdf", description: "asdfasdfasdf",
                              end_date: "24-12-2014")
      expect(campaign).to be_invalid
    end

    it "must have a number for target" do 
      campaign = Campaign.new(title: "adsf", description: "asdfasdf",
                              end_date: "24-12-2013", target: "asdfhwoiegn")
      expect(campaign).to be_invalid
    end

    it "must have a target greater than 10" do 
      campaign = Campaign.new(title: "adsf", description: "asdfasdf",
                              end_date: "24-12-2013", target: 8)
      expect(campaign).to be_invalid
    end
  end
end
