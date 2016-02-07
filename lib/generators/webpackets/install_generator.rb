require 'rails/generators/base'

module Webpackets
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def check_for_node
        unless `which node`.length
          puts "Node not found... exiting"
          exit 0
        end
      end

      def check_for_package_json
        if !File.exists?('package.json')
          puts "No package.json found... exiting. Please run: npm init"
          exit 0
        end
      end

      def npm_install_dependencies
        puts "Runnin npm install"
        `npm install --save-dev webpack webpack-dev-server stats-webpack-plugin`
        puts "Node modules installed"
      end

      def copy_javascript
        copy_file "application.js", "app/assets/javascripts/application.js"
      end

      def copy_wepack
        copy_file "webpack.config.js", "webpack.config.js"
      end

    end
  end
end
