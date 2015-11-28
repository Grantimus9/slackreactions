class Request < ActiveRecord::Base


  def self.top_requesters
    self.group('requesting_user').order('count_requesting_user DESC').limit(3).count('requesting_user')
  end
end
