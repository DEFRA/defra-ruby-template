# frozen_string_literal: true

require "defra_ruby_template/version"

module DefraRubyTemplate
  module Rails
    class Engine < ::Rails::Engine
      initializer "defra_ruby_template.assets.precompile" do |app|
        app.config.assets.precompile <<
          [
            "favicon.ico",
            "favicon.svg",
            "govuk-icon-mask.svg",
            "govuk-icon-180.png",
            "govuk-opengraph-image.png"
          ]
      end
    end
  end
end
