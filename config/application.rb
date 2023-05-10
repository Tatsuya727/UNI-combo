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

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'email-smtp.ap-northeast-1.amazonaws.com',
      port: 587,
      user_name: ENV['SES_SMTP_USERNAME'],
      password: ENV['SES_SMTP_PASSWORD'],
      authentication: :login,
      enable_starttls_auto: true
    }


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
