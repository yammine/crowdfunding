class MyCampaignsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @campaigns = current_user.campaigns.paginate(page: params[:page])
  end
end
