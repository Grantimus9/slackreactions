# encoding: utf-8

class ReactionUploader < CarrierWave::Uploader::Base

  storage :fog
  # storage :file

  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    # This works for the file storage as well as Amazon S3 and Rackspace Cloud Files.
    # Define store_dir as nil if you'd like to store files at the root level.
    nil
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end


end
