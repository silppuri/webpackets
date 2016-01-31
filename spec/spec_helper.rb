$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rails'
require 'webpackets'

module DummyApp
  class Application < Rails::Application; end
end

Rails.application.initialize!
