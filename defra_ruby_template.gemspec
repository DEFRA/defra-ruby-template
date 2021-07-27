# frozen_string_literal: true

# rubocop:disable Gemspec/RequiredRubyVersion
# rubocop:disable Layout/ExtraSpacing
# rubocop:disable Layout/SpaceAroundOperators

require_relative "lib/defra_ruby_template/version"

Gem::Specification.new do |spec|
  spec.name          = "defra_ruby_template"
  spec.version       = DefraRubyTemplate::VERSION
  spec.authors       = ["Toby Privett"]
  spec.email         = ["toby@snaplab.co.uk"]

  spec.summary       = "DEFRA Ruby Template"
  spec.description   = "Adds the GOVUK frontend to a Rails application that uses the Asset Pipeline."
  spec.homepage      = "https://github.com/DEFRA/defra-ruby-template"
  spec.license       = "The Open Government Licence (OGL) Version 3"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "defra_ruby_style"
end

# rubocop:enable Gemspec/RequiredRubyVersion
# rubocop:enable Layout/ExtraSpacing
# rubocop:enable Layout/SpaceAroundOperators
