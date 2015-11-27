CarrierWave.configure do |config|

  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['s3_key_id'],       # required
    :aws_secret_access_key  => ENV['s3_secret']       # required
    # :region                 => ENV['s3_region']  # optional, defaults to 'us-east-1'
  }

  config.fog_directory    = ENV['s3_bucket_name']
  config.fog_public = :true

  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku
end
