require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CrypticCracker
  class Application < Rails::Application
    config.load_defaults 6.0

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:3001'
        resource '*', headers: :any, methods: [:get]
      end
    end
  end
end
