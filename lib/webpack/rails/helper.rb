require 'open-uri'

module Webpack
  module Rails
    module Helper
      def self.manifest_path(name)
        "webpack-#{name}-manifest.json"
      end

      def self.read_manifest(name)
        manifest = ::Rails.root.join('public', 'assets', manifest_path(name))

        name_symbol = "#{name}_manifest".to_sym
        if File.exist?(manifest)
          ::Rails.configuration.webpack[name_symbol] = JSON.parse(
            File.read(manifest),
          ).with_indifferent_access
        else
          host = ::Rails.application.config.webpack.server.host
          port = ::Rails.application.config.webpack.server.port
          manifest = "webpack-#{name}.json"
          url = "http://#{host}:#{port}/#{manifest}"
          JSON.load(open(url)).with_indifferent_access
        end

      end

      def self.webpack_manifest_script
        return '' unless Rails.configuration.webpack[:use_manifest]
        javascript_tag "window.webpackManifest = #{Rails.configuration.webpack[:common_manifest]}"
      end

      def webpack_asset_paths(source)
        return "" unless source.present?
        host = ::Rails.application.config.webpack.server.host
        port = ::Rails.application.config.webpack.server.port
        asset = Webpack::Rails::Helper.read_manifest("common-manifest")["assetsByChunkName"][source]

        if ::Rails.application.config.webpack.server.enabled
          "http://#{host}:#{port}/#{asset}"
        else
          asset
        end
      end
    end
  end
end

