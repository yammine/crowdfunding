class CommentMailer < ActionMailer::Base
  default from: "from@example.com"

  def notify_commentable_owner(comment)
    commentable = comment.commentable
    mail(to: commentable.user.email, subject: "Someone commented on your content.")
  end

end
