class PledgesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_campaign, only: [:create]
  before_action :find_user_pledge, only: [:destroy]

  def new
  end

  def create
    @pledge   = @campaign.pledges.new(pledge_params)
    @pledge.user = current_user
    if @pledge.save
      redirect_to @campaign, notice: "Pledge created"
    else
      render :new
    end
  end

  def destroy
    @pledge.destroy
    render nothing: true
  end


  private

  def find_campaign
    @campaign = Campaign.find params[:campaign_id]
  end

  def find_user_pledge
    @pledge = current_user.pledges.find params[:id]
  end

  def pledge_params
    params.require(:pledge).permit(:amount)
  end


end
