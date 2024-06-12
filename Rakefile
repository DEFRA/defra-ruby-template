# frozen_string_literal: true
require "bundler/gem_tasks"
require "defra_ruby_template/version"

task default: :assets

task "assets" do
  Rake::Task["stylesheet"].execute
  Rake::Task["fonts"].execute
  Rake::Task["images"].execute
  Rake::Task["javascript"].execute
end

task "stylesheet" do
  Rake::FileList["node_modules/govuk-frontend/dist/govuk/govuk-frontend.min.css"].each do |source|
    target = source.sub("node_modules/govuk-frontend/dist/govuk", "vendor/assets/stylesheets")
    mkdir_p(File.dirname(target))
    copy_file source, target
  end
end

task "fonts" do
  Rake::FileList[
     "node_modules/govuk-frontend/govuk/assets/fonts/*.{eot,woff,woff2,ico,svg}"
   ].each do |source|
     target = source.sub("node_modules/govuk-frontend/govuk", "vendor")
     mkdir_p(File.dirname(target))
     copy_file source, target
   end
end

task "images" do
  Rake::FileList[
    "node_modules/govuk-frontend/govuk/assets/images/*.{png,gif,jpg,ico,svg}"
  ].each do |source|
    target = source.sub("node_modules/govuk-frontend/govuk", "vendor")
    mkdir_p(File.dirname(target))
    copy_file source, target
  end
end

task "javascript" do
  Rake::FileList["node_modules/govuk-frontend/dist/govuk/govuk-frontend.min.js"].each do |source|
    target = source.sub("node_modules/govuk-frontend/dist/govuk", "vendor/assets/javascripts")
    mkdir_p(File.dirname(target))
    copy_file source, target
  end
end
