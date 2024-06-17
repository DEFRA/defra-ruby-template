# frozen_string_literal: true

# spec/tasks/assets_spec.rb

require "rake"
require "rspec"

# Load the Rakefile
load File.expand_path("../../Rakefile", __dir__)

RSpec.describe "Rake tasks" do
  before(:all) do
    # Load Rake tasks
    # Rake.application.rake_require("Rakefile")
    Rake::Task.define_task(:environment)
  end

  describe "assets" do
    it "runs without error" do
      expect { Rake::Task["assets"].invoke }.not_to raise_error
    end
  end
end
