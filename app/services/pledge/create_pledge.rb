class Pledge::CreatePledge

   include Virtus.model

   attribute :params, Hash
   attribute :campaign, Campaign
   attribute :user, User

   attribute :pledge, Pledge

   def call
    @pledge = campaign.pledges.new params
    @pledge.user = user

    if @pledge.save
      PledgeMailer.notify_campaign_owner(@pledge).deliver
      PledgeMailer.send_thank_you(@pledge).deliver
    else
      false
    end

   end

end