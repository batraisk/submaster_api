require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SubmasterApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    I18n.available_locales = [:en, :ru]
    # I18n.available_locales = [:en]
    config.active_job.queue_adapter = :sidekiq
    config.autoloader = :classic
    # config.active_record.default_timezone = :utc
    config.time_zone = 'Europe/Moscow'
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
