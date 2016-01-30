require 'open-uri'

module Webpack
  module Rails
    module Helper

      def self.host_url
        host = ::Rails.application.config.webpack.server.host
        port = ::Rails.application.config.webpack.server.port
        "http://#{host}:#{port}"
      end

      def self.manifest_name(name)
        "webpack-#{name.to_s}.json"
      end

      def self.read_manifest(name)
        url = "#{host_url}/#{manifest_name(name)}"
        JSON.load(
          open(url)
        ).with_indifferent_access
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

      def javascript_include_tag(*sources)
        return "" unless sources.present?
        host = ::Rails.application.config.webpack.server.host
        port = ::Rails.application.config.webpack.server.port
        assets = Webpack::Rails::Helper.read_manifest("common-manifest")["assetsByChunkName"]

        sources.map { |source|
          asset = assets[source]
          if ::Rails.application.config.webpack.server.enabled
            super "http://#{host}:#{port}/#{asset}"
          else
            super asset
          end
        }.join('\n').html_safe
      end
    end
  end
end

