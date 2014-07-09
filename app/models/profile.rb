class Profile < ActiveRecord::Base
  
  belongs_to :user

  validates :age, numericality: true
  validates :bio, :age, presence: true

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

end
