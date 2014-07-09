json.(@campaign, :id, :title, :description, :target, :longitude, :latitude)
json.end_date @campaign.end_date.strftime("%Y-%B-%d")