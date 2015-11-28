class User < ActiveRecord::Base
  has_many :reactions

  before_create :create_confirm_code

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
          user.name = auth['info']['name'] || ""
          email = auth['info']['email']
        if email == ENV['admin_email']
          user.role = "admin"
        end
          user.email = email
      end
    end
  end

  def admin?
    role == "admin"
  end

  # Chance of a collision is exceedingly low.
  def create_confirm_code
    self.confirm_code = SecureRandom.urlsafe_base64(5)
  end


end
