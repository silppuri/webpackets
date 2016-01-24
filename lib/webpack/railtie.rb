require 'rails'
require 'rails/railtie'

module Webpack
  class Railtie < Rails::Railtie
    config.webpack = ActiveSupport::OrderedOptions.new
    config.webpack.config_file = 'webpack.config.js'
    config.webpack.binary = 'node_modules/.bin/webpack'

    config.webpack.output_dir = 'public/assets'
    config.after_initialize do
      ActiveSupport.on_load(:action_view) do
        puts "Hello here is mee"
      end
    end
  end
end
