# frozen_string_literal: true
require "bundler/gem_tasks"
require "defra_ruby_template/version"

task default: :assets

task "assets" do
  %w[
    minified_css
    fonts
    images
    stylesheets
    javascripts
  ].each do |task_name|
    Rake::Task[task_name].execute
  end
end

def copy_assets(source_pattern, target_replacement)
  Rake::FileList[source_pattern].each do |source|
    target = source.sub("node_modules/govuk-frontend/dist/govuk", target_replacement)
    mkdir_p(File.dirname(target))
    copy_file source, target
  end
end

task "minified_css" do
  copy_assets("node_modules/govuk-frontend/dist/govuk/govuk-frontend.min.css", "vendor/assets/stylesheets")
end

task "stylesheets" do
  copy_assets("node_modules/govuk-frontend/dist/govuk/**/*.scss", "vendor/assets/stylesheets")
  create_scss_file
end

task "fonts" do
  copy_assets("node_modules/govuk-frontend/dist/govuk/assets/fonts/*.{eot,woff,woff2,ico,svg}", "vendor")
end

task "images" do
  copy_assets("node_modules/govuk-frontend/dist/govuk/assets/images/*.{png,gif,jpg,ico,svg}", "vendor")
end

task "javascripts" do
  Rake::FileList["node_modules/govuk-frontend/dist/govuk/all.bundle.js"].each do |source|
    target = source.sub("node_modules/govuk-frontend/dist/govuk", "vendor/assets/javascripts")
    target = target.sub("all.bundle.js", "defra_ruby_template.js")
    mkdir_p(File.dirname(target))
    copy_file source, target
  end
end

def create_scss_file
  content = <<-SCSS
// Using Rails with the asset pipeline so set the helper methods
$govuk-font-url-function: 'image-url';
$govuk-image-url-function: 'font-url';

  SCSS

  source_file = "node_modules/govuk-frontend/dist/govuk/all.scss"
  target_file = "vendor/assets/stylesheets/defra_ruby_template.scss"

  mkdir_p(File.dirname(target_file))
  File.open(target_file, "w") do |file|
    file.write(content)
    file.write(File.read(source_file))
  end
end
