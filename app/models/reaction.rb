class Reaction < ActiveRecord::Base

  # Carrierwave
  mount_uploader :image, ReactionUploader

  belongs_to :user





end
