require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require 'awesome_print'
require 'xmlsimple'

# get product
require 'time'
require 'uri'
require 'openssl'
require 'base64'
# read file xml
require 'nokogiri'

# Your Access Key ID, as taken from the Your Account page
ACCESS_KEY_ID = "AKIAJWPWTVNYFLW7EKHQ"

# Your Secret Key corresponding to the above ID, as taken from the Your Account page
SECRET_KEY = "C9ZIPiqI5j31xbH8N83rNOzp4XAQ8FuRlVUGlMTy"

# The region you are interested in
ENDPOINT = "webservices.amazon.com"

REQUEST_URI = "/onca/xml"



module Purie
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
