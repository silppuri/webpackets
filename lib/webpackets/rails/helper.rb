require 'open-uri'

module Webpackets
  module Rails
    module Helper

      def javascript_include_tag(*sources)
        assets = manifest["assetsByChunkName"]
        sources.map { |source|
          asset = assets[source]
          if ::Rails.application.config.webpack.server.enabled
            super "#{origin}/#{asset}"
          else
            super asset
          end
        }.join('\n').html_safe
      end

      protected

      def origin
        ::Rails.application.config.webpack.server.origin
      end

      def manifest_path
        ::Rails.application.config.webpack.manifest_path
      end

      def manifest
        JSON.load(
          open(manifest_path)
        ).with_indifferent_access
      end
    end
  end
end

