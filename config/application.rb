require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require 'awesome_print'
require 'amazon/ecs'
require 'nokogiri'

Amazon::Ecs.configure do |options|
  options[:AWS_access_key_id] = 'AKIAJWPWTVNYFLW7EKHQ'
  options[:AWS_secret_key] = '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'
  options[:associate_tag] = 'phuongvyshop-20'
end


module Purie
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
