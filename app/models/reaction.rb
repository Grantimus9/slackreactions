class Reaction < ActiveRecord::Base
  # Carrierwave
  mount_uploader :image, ReactionUploader

  belongs_to :user
  before_save :downcase_keywords


  # Find and return a single response to POST to Slack
  def self.return_to_slack(text)
    text.downcase!
    @search = Reaction.search do
      fulltext text
    end
    @reactions = @search.results

    return nil if @reactions.nil?
    
    # If there are multiple search matches, choose a random one.
    @reactions.many? ? @response = @reactions.sample : @response = @reactions.first

    @response
  end

  # Rely on the Sunspot Solr gem/system to handle this
  searchable do
    text :keywords
  end

  def downcase_keywords
    keywords.downcase
  end

end
