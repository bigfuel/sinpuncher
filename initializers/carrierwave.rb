CarrierWave.configure do |config|
  config.permissions = 0666
  config.storage = :fog
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => App.settings.aws_access_key_id,
    :aws_secret_access_key  => App.settings.aws_secret_access_key
  }
  config.fog_directory = App.settings.s3_bucket
  config.fog_public = true
  config.cache_dir = "tmp/uploads"

  config.fog_host = "https://#{App.settings.uploader_host}"
end