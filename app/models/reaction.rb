class Reaction < ActiveRecord::Base

  # Carrierwave
  mount_uploader :image, ReactionUploader

  belongs_to :user

  # Rely on the Sunspot Solr gem/system to handle this
  searchable do
    text :keywords
  end

end
