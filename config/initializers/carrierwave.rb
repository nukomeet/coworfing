CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIA3OQB6KG54UQAZA',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'coworfing-production'
end
