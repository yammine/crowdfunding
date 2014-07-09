json.array! @campaigns do |campaign|
  json.id          campaign.id
  json.title       campaign.title
  json.created_at  campaign.created_at.strftime("%Y-%B-%d")
end