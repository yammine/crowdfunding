class User < ActiveRecord::Base

  has_secure_password

  has_one :profile, dependent: :destroy

  has_one :api_key, dependent: :destroy

  accepts_nested_attributes_for :profile
  
  has_many :campaigns, dependent: :destroy

  has_many :comments

  has_many :pledges, dependent: :destroy
  has_many :pledged_campaign, through: :pledges, source: :campaign

  has_many :discussions, dependent: :destroy

  
  validates :email, presence: true, email_format: true,
            uniqueness: true
  
  mount_uploader :avatar, AvatarUploader

  before_create :generate_api_key

  before_save :capitalize_first_name
  
  delegate :longitude, :latitude, to: :profile

  def full_name
    if first_name && last_name
      "#{first_name} #{last_name}"
    elsif first_name
      first_name
    else
      email
    end
  end

  private

  def generate_api_key
    self.api_key = ApiKey.new
  end

  def capitalize_first_name
    self.first_name.capitalize! if first_name
  end

end
