CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAICLGJBCMVXOJX7AQ',
    :aws_secret_access_key  => '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'
  }
  if [Rails.env] == 'production'
    config.fog_directory  = 'wegottago-production'
  else
    config.fog_directory  = 'wegottago-staging'
  end
end