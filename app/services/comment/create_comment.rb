class Comment::CreateComment

   include Virtus.model

   attribute :params, Hash
   attribute :user, User
   attribute :commentable, Discussion || Campaign

   attribute :comment, Comment

   def call
    @comment = commentable.comments.new params
    @comment.user = user

    if @comment.save
      CommentMailer.notify_commentable_owner(@comment).deliver
    else
      false
    end

  end


end