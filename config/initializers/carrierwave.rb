CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['aws_id'],
    :aws_secret_access_key  => ENV['aws_key']
  }
  if [Rails.env] == 'production'
    config.fog_directory  = 'wegottago.production'
  else
    config.fog_directory  = 'wegottago.staging'
  end
end
