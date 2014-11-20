CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_ID'],
    :aws_secret_access_key  => ENV['S3_KEY'],
    :host                   => 's3.amazonaws.com',             # optional, defaults to nil
    :endpoint               => 'https://s3.amazonaws.com' # optional, defaults to nil
  }
  if [Rails.env] == 'production'
    config.fog_directory  = 'wegottago.production'
  else
    config.fog_directory  = 'wegottago.staging'
  end
end
