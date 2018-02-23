# https://gist.github.com/marcusmalmberg/4073144

# CarrierWave.configure do |config|
  
#   # Use local storage if in development or test
#   if Rails.env.development? || Rails.env.test?
#     CarrierWave.configure do |config|
#       config.storage = :fog
#     end
#   end
  
#   config.fog_credentials = {
#     :provider               => 'AWS',                             # required
#     :aws_access_key_id      => 'xx',            # required
#     :aws_secret_access_key  => 'xx',     # required
#     :region                 => 'ap-southeast-1'                        # optional, defaults to 'us-east-1'
#   }
#   config.fog_directory  = 'next-academy-practice'               # required
#   #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
#   #config.fog_public     = false                                  # optional, defaults to true
#   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
# end

#https://github.com/carrierwaveuploader/carrierwave#using-amazon-s3

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV['aws_access_key_id'],                        # required
    aws_secret_access_key: ENV['aws_secret_access_key'],                        # required
    region:                'ap-southeast-1',                  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'next-academy-practice'                                   # required
  config.fog_public     = false                                                 # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end