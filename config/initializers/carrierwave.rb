CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAIWS4SRSYJ66KIHIA',
    :aws_secret_access_key  => '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'
  }
  if [Rails.env] == 'production'
    config.fog_directory  = 'wegottago.production'
  else
    config.fog_directory  = 'wegottago.staging'
  end
end
