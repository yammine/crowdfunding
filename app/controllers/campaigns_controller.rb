class CampaignsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_campaign, only: [:show]
  before_action :find_user_campaign, only: [:edit, :update, :destroy]

  def index
    @campaigns = Campaign.published.paginate(page: params[:page])
    respond_to do |format|
      format.html { render }
      format.json { render json: @campaigns.to_json }
    end
  end

  def new
    @campaign = Campaign.new
    3.times { @campaign.reward_levels.build }
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.user = current_user
    if @campaign.save
      redirect_to @campaign, notice: "Campaign successfully created."
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @pledges = @campaign.pledges
    respond_to do |format|
      format.html { render }
      format.json { render json: @campaign.to_json }
    end
  end

  def edit
    authorize! :edit, @campaign

  end

  def update
    authorize! :update, @campaign

    if @campaign.update_attributes(campaign_params)
      redirect_to @campaign, notice: "Campaign successfully updated"
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @campaign

    @campaign.destroy
    redirect_to campaigns_path, notice: "Successfully deleted campaign."
  end

  private

  def find_user_campaign
    @campaign = Campaign.find params[:id]
  end

  def find_campaign
    @campaign = Campaign.friendly.find(params[:id]).decorate
  end

  def campaign_params
    params.require(:campaign).permit(:title, :description,
                                     :end_date, :target, :address, :state,
                                     {reward_levels_attributes: [:name, :amount, :details, :id, :_destroy]}
                                     )
  end

end
