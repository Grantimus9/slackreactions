class Reaction < ActiveRecord::Base
  # Carrierwave
  mount_uploader :image, ReactionUploader

  belongs_to :user
  before_save :downcase_keywords

  # Rely on the Sunspot Solr gem/system to handle this
  searchable do
    text :keywords
  end

  def downcase_keywords
    keywords.downcase
  end

end
