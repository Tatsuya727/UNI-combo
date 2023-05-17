require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UNICombo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    #追加
    config.autoload_paths += %W(#{config.root}/app/uploaders)
    config.active_storage.service = :local

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "localhost:3000", "unicombohub.com"

        resource "*",
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Customizing Rails Generators
    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false 
      g.test_framework :rspec, 
        fixtures: false,
        request_specs: false, 
        view_specs: false, 
        helper_specs: false, 
        routing_specs: false 
    end
  end
end
