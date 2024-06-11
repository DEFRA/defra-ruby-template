# frozen_string_literal: true

require "bundler/gem_tasks"
require "defra_ruby_template/version"

task default: :assets

task "assets" do
  Rake::Task["stylesheets"].execute
  Rake::Task["fonts"].execute
  Rake::Task["images"].execute
  Rake::Task["javascripts"].execute
end

task "stylesheets" do
  Rake::FileList["node_modules/govuk-frontend/dist/**/*.scss"].each do |source|
    target = source.sub("node_modules/govuk-frontend/dist", "vendor/assets/stylesheets")
    mkdir_p(File.dirname(target))
    copy_file source, target
  end
end

task "fonts" do
  Rake::FileList[
    "node_modules/govuk-frontend/dist/govuk/assets/fonts/*.{eot,woff,woff2,ico,svg}"
  ].each do |source|
    target = source.sub("node_modules/govuk-frontend/dist/govuk/assets/fonts", "vendor/assets/fonts")
    mkdir_p(File.dirname(target))
    copy_file source, target
  end
end

task "images" do
  Rake::FileList[
    "node_modules/govuk-frontend/dist/govuk/assets/images/*.{png,gif,jpg,ico,svg}"
  ].each do |source|
    target = source.sub("node_modules/govuk-frontend/dist/govuk/assets/images", "vendor/assets/images")
    mkdir_p(File.dirname(target))
    copy_file source, target
  end
end

task "javascripts" do
  Rake::FileList["node_modules/govuk-frontend/dist/govuk/all.mjs"].each do |source|
    target = source.sub("node_modules/govuk-frontend/dist/govuk", "vendor/assets/javascripts")
    target = target.sub("all.mjs", "defra_ruby_template.js")
    mkdir_p(File.dirname(target))
    copy_file source, target
  end
end
