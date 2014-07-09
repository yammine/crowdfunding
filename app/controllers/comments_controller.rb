class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_commentable

  def create
    service = Comment::CreateComment.new(params: comment_params,
                                         user: current_user,
                                         commentable: @commentable)
    if service.call
      redirect_to @commentable, notice: "Comment created."
    else
      @commentable = service.comment
      render "#{@commentable.class.name.underscore.pluralize}/show"
    end
  end

  def destroy

  end

  private

  def find_commentable
    if params[:discussion_id]
      @discussion = @commentable = Discussion.find params[:discussion_id]
    elsif params[:campaign_id]
      @campaign = @commentable = Campaign.find params[:campaign_id]
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
