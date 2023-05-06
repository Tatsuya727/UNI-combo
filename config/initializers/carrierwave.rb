if Rails.env.production?
    CarrierWave.configure do |config|
        config.fog_provider = 'fog/aws'
        config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region: ENV['AWS_REGION']
        }
        config.fog_directory  = ENV['S3_BUCKET_NAME']
        config.fog_public     = false
        config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
        config.storage = :fog
    end
else
    CarrierWave.configure do |config|
        config.root = Rails.root.join('tmp')
        config.cache_dir = 'carrierwave'

        config.storage = :file
        config.enable_processing = !Rails.env.test?
    end
end