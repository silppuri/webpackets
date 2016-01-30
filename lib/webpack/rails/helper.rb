require 'open-uri'

module Webpack
  module Rails
    module Helper

      def javascript_include_tag(*sources)
        return "" unless sources.present?

        url = host_url()
        assets = read_manifest(:common)["assetsByChunkName"]
        sources.map { |source|
          asset = assets[source]
          if ::Rails.application.config.webpack.server.enabled
            super "#{url}/#{asset}"
          else
            super asset
          end
        }.join('\n').html_safe
      end

      protected

      def host_url
        host = ::Rails.application.config.webpack.server.host
        port = ::Rails.application.config.webpack.server.port
        "http://#{host}:#{port}"
      end

      def manifest_name(name)
        "webpack-#{name.to_s}-manifest.json"
      end

      def read_manifest(name)
        url = "#{host_url}/#{manifest_name(name)}"
        JSON.load(
          open(url)
        ).with_indifferent_access
      end
    end
  end
end

