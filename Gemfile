# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in defra-ruby-template.gemspec
gemspec

gem "rake", "~> 13.0"
gem "rspec"

group :development, :test do
  # The entry point is only valid when Sprockets has registered the Rails asset
  # helpers as Sass functions, so the compile spec needs the real pipeline.
  gem "dartsass-sprockets"

  # defra_ruby_style stopped depending on rubocop in 0.4.0, and its default.yml
  # loads these three plugins, so they have to be declared here.
  gem "defra_ruby_style"
  gem "rubocop"
  gem "rubocop-factory_bot"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end
