class User < ActiveRecord::Base
  has_many :reactions


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



end
