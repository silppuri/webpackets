require 'rails'
require 'rails/railtie'
# require 'webpack/rails/helper'

module Webpack
  class Railtie < ::Rails::Railtie

    config.webpack = ActiveSupport::OrderedOptions.new
    config.webpack.config_file = 'webpack.config.js'
    config.webpack.binary = 'node_modules/.bin/webpack'

    config.webpack.server = ActiveSupport::OrderedOptions.new
    config.webpack.server.host = 'localhost'
    config.webpack.server.port = '8080'
    config.webpack.server.binary = 'node_modules/.bin/webpack-dev-server'
    config.webpack.server.enabled = !::Rails.env.production?

    config.webpack.output_dir = 'public/assets'
    config.webpack.public_path = 'assets'

    config.after_initialize do
      ActiveSupport.on_load(:action_view) do
        if !::Rails.env.production?
          system('./node_modules/.bin/webpack-dev-server')
        end
      end
    end
  end
end
