# frozen_string_literal: true

require "defra_ruby_template/version"

module DefraRubyTemplate
  module Rails
    class Engine < ::Rails::Engine
      initializer "defra_ruby_template.assets.precompile" do |app|
        app.config.assets.precompile <<
          [
            "favicon.ico",
            "govuk-apple-touch-icon-152x152.png",
            "govuk-apple-touch-icon-167x167.png",
            "govuk-apple-touch-icon-180x180.png",
            "govuk-apple-touch-icon.png",
            "govuk-crest-2x.png",
            "govuk-crest.png",
            "govuk-logotype-crown.png",
            "govuk-mask-icon.svg",
            "govuk-opengraph-image.png",
          ]
      end
    end
  end
end
