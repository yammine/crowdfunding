class Api::V1::CampaignsController < Api::BaseController

  def index
    @campaigns = Campaign.all
    # render json: @campaigns.to_json
  end

  def show
    @campaign = Campaign.find params[:id]
  end

end
