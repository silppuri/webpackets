require 'spec_helper'
require 'rails'
require 'action_view'

require 'webpackets'
require 'webpackets/rails/helper'

describe Webpackets::Rails::Helper do
  MANIFEST_PATH = File.expand_path("../../fixtures/manifest.json", __FILE__)

  before :each do
    @view = ActionView::Base.new
    @view.extend ::Webpackets::Rails::Helper
    ::Rails.application.config.webpack.manifest_path = MANIFEST_PATH
    @origin = ::Rails.application.config.webpack.server.origin
  end

  it "is defined" do
    Webpackets::Rails::Helper
  end

  it "#javascript_include_tag" do
    file_name = "#{@origin}/#{JSON.load(open(MANIFEST_PATH))["assetsByChunkName"]["main"]}"
    puts file_name
    expect(@view.javascript_include_tag(:main))
      .to eq(%(<script src="#{file_name}"></script>))
    expect(@view.javascript_include_tag("main"))
      .to eq(%(<script src="#{file_name}"></script>))
  end
end
