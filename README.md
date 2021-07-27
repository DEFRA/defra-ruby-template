# Defra Ruby Template

![Build Status](https://github.com/DEFRA/defra-ruby-template/workflows/CI/badge.svg?branch=main)
[![security](https://hakiri.io/github/DEFRA/defra-ruby-template/main.svg)](https://hakiri.io/github/DEFRA/defra-ruby-template/main)
[![Gem Version](https://badge.fury.io/rb/defra_ruby_template.svg)](https://badge.fury.io/rb/defra_ruby_address)
[![Licence](https://img.shields.io/badge/Licence-OGLv3-blue.svg)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3)

## About

Adds a GOV.UK-ready layout template and the [govuk_frontend assets](https://github.com/alphagov/govuk-frontend) to a Rails application.

## Installation

Add this line to the application's Gemfile:

```ruby
gem 'defra-ruby-template'
```

And then execute:

    $ bundle

## Usage

The Rails application will need to have SCSS enabled (e.g. `sass-rails`).

This gem includes the `defra_ruby_template` layout, and can be included  in a Rails project by adding the following to the default layout (e.g. `application.html.erb`)

```

<% content_for :page_title do %>
    Page title or defaults to the i18n `global_proposition_header`
<% end %>

<% content_for :head do %>
  Stylesheets, Analytics, etc.
<% end %>

<% content_for :header_content do %>
 Application name and top-level links
<% end %>

<% content_for :phase_banner do %>
  Phase banner, e.g Alpha, Beta, etc
<% end %>

<% content_for :back_link do %>
    Link to go back
<% end %>

<% content_for :footer do %>
  Application specific footer links
<% end %>

<%= render template: "layouts/defra_ruby_template" %>

```


## Updating the govuk-frontend

To update to the latest govuk-frontend files:

```
$ npm install govuk-frontend --save
$ rake
```

Then update the [`DefraRubyTemplate::Version`](https://github.com/DEFRA/defra-ruby-template/blob/main/lib/defra_ruby_template/version.rb) so that it matches the `govuk-frontend` [version](https://github.com/alphagov/govuk-frontend/tags).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DEFRA/defra-ruby-template.
