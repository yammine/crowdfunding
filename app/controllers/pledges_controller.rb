class PledgesController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :find_campaign, only: [:index, :new, :create]
  before_action :find_user_pledge, only: [:destroy]

  def index
    @pledges = @campaign.pledges
    respond_to do |format|
      format.html { render }
      format.json { render json: @pledges.to_json}
    end
  end

  def new
    @pledge = Pledge.new
  end

  def create
    service = Pledge::CreatePledge.new(params: pledge_params,
                                       user: current_user,
                                       campaign: @campaign)
    if service.call
      redirect_to @campaign, notice: "Pledge created"
    else
      @pledge = service.pledge
      render :new
    end
  end

  def destroy
    @pledge.destroy
    render nothing: true
  end


  private

  def find_campaign
    @campaign = Campaign.friendly.find params[:campaign_id]
  end

  def find_user_pledge
    @pledge = current_user.pledges.find params[:id]
  end

  def pledge_params
    params.require(:pledge).permit(:amount)
  end


end
