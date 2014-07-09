class ApiKey < ActiveRecord::Base
  belongs_to :user

  before_create :generate_access_token

  private

  def generate_access_token
    begin 
      self.access_token = SecureRandom.hex
    end while ApiKey.exists?(access_token: access_token)

  end

end
