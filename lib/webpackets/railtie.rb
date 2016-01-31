require 'rails'
require 'rails/railtie'
require 'webpackets/rails/helper'
require 'webpackets/server'

module Webpackets
  class Railtie < ::Rails::Railtie

    config.webpack = ActiveSupport::OrderedOptions.new
    config.webpack.config_file = 'webpack.config.js'

    config.webpack.server = ActiveSupport::OrderedOptions.new
    config.webpack.server.origin = 'http://localhost:8080'
    config.webpack.server.cmd = './node_modules/.bin/webpack-dev-server'
    config.webpack.server.enabled = !::Rails.env.production?
    config.webpack.manifest_path = "http://localhost:8080/webpack-common-manifest.json"

    config.after_initialize do |app|
      ActiveSupport.on_load(:action_view) do
        include Webpackets::Rails::Helper

        if app.config.webpack.server.enabled
          Webpackets::Server.new(app.config.webpack.server).start
        end
      end
    end
  end
end
