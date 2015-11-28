class StaticPagesController < ApplicationController
  skip_authorization_check
  def index
    redirect_to reactions_url if current_user
  end
end
