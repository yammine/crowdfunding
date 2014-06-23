class User < ActiveRecord::Base

  has_secure_password
  
  validates :email, presence: true, email_format: true,
            uniqueness: true
  
  before_save :capitalize_first_name

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

  def capitalize_first_name
    self.first_name.capitalize! if first_name
  end

end
