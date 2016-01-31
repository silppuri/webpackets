require 'spec_helper'
require 'rails'
require 'rails/railtie'
require 'active_support'
require 'active_support/dependencies'
require 'action_view'


describe "Webpackets::Railtie" do
  attr_reader :app

  before :each do
    require 'webpackets/railtie'
    @app = Class.new(Rails::Application)
    @app.config.eager_load = false
    @app.config.time_zone = 'UTC'
    @app.config.middleware ||= Rails::Configuration::MiddlewareStackProxy.new
    @app.config.active_support.deprecation = :notify
    ActionView::Base # load ActionView
  end

  it "app is initializable" do
    app.initialize!
  end
end
