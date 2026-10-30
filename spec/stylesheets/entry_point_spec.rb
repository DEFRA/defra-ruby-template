# frozen_string_literal: true

require "dartsass-sprockets"
require "rspec"

# Stand-ins for the image-url and font-url functions Sprockets registers. The
# /helped/ marker shows in the CSS which URLs went through them.
module StubAssetHelpers
  def image_url(path)
    SassC::Script::Value::String.new("url(/helped/#{path.value})", :identifier)
  end

  def font_url(path, _options = nil)
    SassC::Script::Value::String.new("url(/helped/#{path.value})", :identifier)
  end
end

CollectingLogger = Struct.new(:warnings) do
  def warn(message, *_args, **_options) = warnings << message
  def debug(*_args, **_options); end
end

# Compiled through Sprockets, which supplies the Sass importer and the asset
# helpers, because that is how the apps compile it.
RSpec.describe "vendor/assets/stylesheets/defra_ruby_template.scss" do
  let(:logger) { CollectingLogger.new([]) }

  let(:css) do
    file = "vendor/assets/stylesheets/defra_ruby_template.scss"

    SassC::Engine.new(
      File.read(file),
      filename: file,
      load_paths: [File.dirname(file)],
      importer: SassC::Rails::Importer,
      functions: StubAssetHelpers,
      logger: logger,
      sprockets: { context: double(depend_on: nil), environment: nil, dependencies: [] }
    ).render
  end

  it "compiles govuk-frontend's styles" do
    expect(css).to include(".govuk-button")
  end

  it "compiles without a single deprecation warning" do
    css

    expect(logger.warnings).to be_empty
  end

  it "resolves asset URLs through the Rails helpers", :aggregate_failures do
    expect(css).to include("url(/helped/")
    expect(css).not_to match(%r{url\(["']?/assets/(images|fonts)/})
  end
end
