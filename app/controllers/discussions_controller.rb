class DiscussionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @discussions = Discussion.all
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user = current_user
    if @discussion.save
      redirect_to @discussion, notice: "Discussion created!"
    else
      render :new
      flash.now[:alert] = "Problem creating discussion"
    end
  end

  def show
    @discussion = Discussion.find params[:id]
    @comment = Comment.new
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end

end
