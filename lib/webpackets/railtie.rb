require 'rails'
require 'rails/railtie'
require 'webpackets/rails/helper'
require 'webpackets/server'

module Webpackets
  class Railtie < ::Rails::Railtie

    config.webpack = ActiveSupport::OrderedOptions.new
    config.webpack.config_file = 'webpack.config.js'
    config.webpack.binary = 'node_modules/.bin/webpack'
    config.webpack.use_manifest = true

    config.webpack.server = ActiveSupport::OrderedOptions.new
    config.webpack.server.host = 'localhost'
    config.webpack.server.port = '8080'
    config.webpack.server.cmd = './node_modules/.bin/webpack-dev-server'
    config.webpack.server.enabled = !::Rails.env.production?

    config.webpack.output_dir = 'public/assets'
    config.webpack.public_path = 'assets'

    config.after_initialize do |app|
      config = app.config

      ActiveSupport.on_load(:action_view) do
        include Webpackets::Rails::Helper

        Webpackets::Server.new(config.webpack.server).start
      end
    end
  end
end
