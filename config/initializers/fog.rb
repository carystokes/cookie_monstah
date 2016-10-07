CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: './env/AWS_ACCESS_KEY_ID',
    aws_secret_access_key: './env/AWS_SECRET_ACCESS_KEY'
  }

  config.fog_directory = './env/S3_BUCKET'
  config.fog_public = false
end
