module CampaignsHelper

  def generate_map_json(campaigns)
    Gmaps4rails.build_markers(campaigns) do |campaign, marker|
      marker.lat campaign.latitude
      marker.lng campaign.longitude
      link = link_to campaign.title, campaign_path(campaign)
      marker.infowindow "#{link}<br>#{campaign.description.truncate(25)}"
    end
  end


end
