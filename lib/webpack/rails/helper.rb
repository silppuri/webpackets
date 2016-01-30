module Webpack
  module Rails
    module Helper
      def self.manifest_path(name)
        "webpack-#{name}-manifest.json"
      end

      def self.read_manifest(name)
        manifest = ::Rails.root.join('public', 'assets', manifest_path(name))

        if File.exist?(manifest)
          name_symbol = "#{name}_manifest".to_sym
          ::Rails.configuration.webpack[name_symbol] = JSON.parse(
            File.read(manifest),
          ).with_indifferent_access
        end

      end

      def webpack_manifest_script
        return '' unless Rails.configuration.webpack[:use_manifest]
        javascript_tag "window.webpackManifest = #{Rails.configuration.webpack[:common_manifest]}"
      end

      def webpack_asset_paths(source)
        return "" unless source.present?
        #
        # paths = Webpack::Rails::Manifest.asset_paths(source)
        # host = ::Rails.application.config.webpack.server.host
        # port = ::Rails.application.config.webpack.server.port
        #
        # if ::Rails.application.config.webpack.server.enabled
        #   paths.map! do |path|
        #     "http://#{host}:#{port}#{path}"
        #   end
        # end
        #
        # puts "Paths: ", paths
        "http://localhost:8080/bundle.js"
      end
    end
  end
end

