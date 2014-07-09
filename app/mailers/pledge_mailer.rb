class PledgeMailer < ActionMailer::Base
  default from: "from@example.com"


  def notify_campaign_owner(pledge)
    campaign = pledge.campaign
    mail(to: campaign.user.email, subject: "Someone pledged on your campaign")
  end

  def send_thank_you(pledge)
    mail(to: pledge.user.email, subject: "Thank you for pledging.")
  end

end
