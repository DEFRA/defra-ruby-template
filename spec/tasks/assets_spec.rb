# frozen_string_literal: true

require "rake"
require "rspec"

# Load the Rakefile
load File.expand_path("../../Rakefile", __dir__)

RSpec.describe "Rake tasks" do
  before(:each) do
    Rake::Task["minified_css"].reenable
    Rake::Task["fonts"].reenable
    Rake::Task["images"].reenable
    Rake::Task["stylesheets"].reenable
    Rake::Task["javascripts"].reenable
  end

  describe "assets:minified_css" do
    it "runs without error" do
      expect { Rake::Task["minified_css"].invoke }.not_to raise_error
    end
  end

  describe "assets:fonts" do
    it "runs without error" do
      expect { Rake::Task["fonts"].invoke }.not_to raise_error
    end
  end

  describe "assets:images" do
    it "runs without error" do
      expect { Rake::Task["images"].invoke }.not_to raise_error
    end
  end

  describe "assets:stylesheets" do
    it "runs without error" do
      expect { Rake::Task["stylesheets"].invoke }.not_to raise_error
    end
  end

  describe "assets:javascripts" do
    it "runs without error" do
      expect { Rake::Task["javascripts"].invoke }.not_to raise_error
    end
  end

  describe "assets" do
    it "runs without error" do
      expect { Rake::Task["assets"].invoke }.not_to raise_error
    end
  end
end
