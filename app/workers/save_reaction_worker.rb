class SaveReactionWorker
  include Sidekiq::Worker

  def perform(user_id, keywords_string, img_url)
    @user = User.find(user_id)
    keywords = keywords_string
    url = img_url
    @reaction = @user.reactions.new( keywords: keywords, remote_image_url: url )
    @reaction.save!
  end

end
