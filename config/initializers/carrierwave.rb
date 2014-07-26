CarrierWave.configure do |config|
  if Rails.env.production?
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => ENV['S3_KEY'],       # required
      :aws_secret_access_key  => ENV['S3_SECRET'],       # required
      :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
    config.fog_public = false
    config.storage = :fog
  else
    config.storage = :file
  end
end
