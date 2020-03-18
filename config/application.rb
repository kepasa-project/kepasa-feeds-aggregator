require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kepasa
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # enable Garbage Collector for New Relic
    GC::Profiler.enable
    
    config.active_job.queue_adapter = :sidekiq
    
    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    # config.autoload_paths += %W(#{config.root}/app/workers)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.before_configuration do
        I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
        I18n.default_locale = :en
        I18n.reload!
    end
    
    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true

    #for HEROKU
    config.assets.initialize_on_precompile = false

    # Set the Font Awesome
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # facebook connection
    # Koala.config.api_version = 'v2.0'

    # enforce encoding for Feedjira 
    config.encoding = "utf-8" 

  end
end