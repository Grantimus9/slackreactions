class Reaction < ActiveRecord::Base
  # Search
  include PgSearch

  pg_search_scope :search_any_word_trigram,
                 :against => :keywords,
                 :using => {
                   :tsearch => {:any_word => true},
                   :trigram => {
                     :threshold => 0.1
                   }
                 }

  # Carrierwave
  mount_uploader :image, ReactionUploader

  belongs_to :user
  before_save :downcase_keywords


  # Find and return a single response to POST to Slack
  def self.return_to_slack(text)
    text.downcase!

    @reactions = Reaction.search_any_word_trigram(text)

    return nil if @reactions.nil?

    # If there are multiple search matches, choose a random one.
    @reactions.many? ? @response = @reactions.sample : @response = @reactions.first

    @response
  end

  def downcase_keywords
    @keywords = self.keywords
    self.update_attribute(:keywords, @keywords.downcase)
  end

end
