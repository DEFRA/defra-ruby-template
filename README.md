# Defra Ruby Template

![Build Status](https://github.com/DEFRA/defra-ruby-template/workflows/CI/badge.svg?branch=main)
[![security](https://hakiri.io/github/DEFRA/defra-ruby-template/main.svg)](https://hakiri.io/github/DEFRA/defra-ruby-template/main)
[![Gem Version](https://badge.fury.io/rb/defra_ruby_template.svg)](https://badge.fury.io/rb/defra_ruby_address)
[![Licence](https://img.shields.io/badge/Licence-OGLv3-blue.svg)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3)

## About

Adds a GOV.UK-ready layout template and the [govuk_frontend assets](https://github.com/alphagov/govuk-frontend) to a Rails application.

The gem's major and minor version track the version of govuk-frontend it
vendors, so 6.4.x of this gem ships govuk-frontend 6.4.0. Patch releases are
changes to the gem itself.

## Installation

Add this line to the application's Gemfile:

```ruby
gem 'defra-ruby-template'
```

And then execute:

    $ bundle

## Usage

This gem includes the `defra_ruby_template` layout, which is rendered from the
application's own layout (e.g. `application.html.erb`). Fill the slots it
provides with `content_for`, then render it:

```erb
<% content_for :page_title do %>
    Page title or defaults to the i18n `global_proposition_header`
<% end %>

<% content_for :head do %>
  Stylesheets, Analytics, etc.
<% end %>

<% content_for :cookies_banner do %>
  Cookie banner
<% end %>

<% content_for :header_content do %>
  Service name and navigation - see "Service navigation" below
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

### Stylesheets

The gem's stylesheet entry point is a Sass module. Load it from the
application's own stylesheet with `@use`:

```scss
@use "defra_ruby_template" as *;
```

That emits govuk-frontend's CSS and makes its settings, tools and helpers
available unprefixed, the way `@import` did - `govuk-colour`, `govuk-font`,
`$govuk-text-colour` and so on. The same rule configures govuk-frontend's own
settings:

```scss
@use "defra_ruby_template" as * with (
  $govuk-assets-path: "/custom-assets/"
);
```

Unlike `@import`, a `@use` applies only to the file it appears in, and it has
to come before any other rule in that file. A partial that is still
`@import`ed is pulled into the importing file's scope, so it keeps working
untouched - only a partial loaded with `@use` needs its own `@use` line.

## Requirements

### Dart Sass

**govuk-frontend 6 cannot be compiled by LibSass, and therefore not by
`sassc-rails`.** Its stylesheets are Sass modules built on `@use`/`@forward`,
and its support for `@import` callers depends on Dart Sass resolving sibling
`*.import.scss` files. LibSass implements neither. It does not fail loudly
either: it passes the `@use` rules through as literal CSS at-rules, so an
application still boots and still serves a stylesheet - one containing no
styles at all.

An application on `sassc-rails` needs to move to a Dart Sass pipeline before
upgrading to this version.

The recommended option is [`dartsass-sprockets`][dartsass-sprockets]. It is a
fork of `sassc-rails` that keeps the same Sprockets integration and delegates to
Dart Sass via `sass-embedded`, so `app/assets/stylesheets/application.css.scss`
and the `image-url`/`font-url` helpers keep working and the change is confined
to the Gemfile:

```ruby
# gem "sassc-rails"
gem "dartsass-sprockets"
```

`dartsass-rails` will not work. It compiles outside Sprockets, so the Rails
asset helpers are not registered as Sass functions and this gem's stylesheet
fails to compile. Serving the prebuilt
`vendor/assets/stylesheets/govuk-frontend.min.css` and dropping SCSS compilation
altogether is the other option, but it gives up the settings, tools and helpers
that application stylesheets use.

Dart Sass warns that `@import` is deprecated. Nothing the gem ships uses it, so
an application that loads the gem with `@use` and has converted its own
partials does not need `config.sass.silence_deprecations = ["import"]`.

[dartsass-sprockets]: https://github.com/tablecheck/dartsass-sprockets

### govuk_design_system_formbuilder

Pin `govuk_design_system_formbuilder` to `~> 6.4.0`. That is the release that
tracks govuk-frontend 6.4.0; earlier 6.x releases target earlier govuk-frontend
6.x versions, and 5.x emits govuk-frontend 5 markup.

### Content Security Policy

govuk-frontend gates over a hundred CSS rule blocks and all of its component
JavaScript on the `govuk-frontend-supported` class, and `initAll()` raises a
`SupportError` if the class is absent. Upstream's template sets it from an
inline `<script>`, which a strict `script-src` blocks.

This gem instead ships that one statement as an asset,
`defra_ruby_template_supported.js`, and the layout includes it at the top of
`<body>`. No inline script is used, so no `unsafe-inline` or nonce is needed for
it.

## Upgrading from 6.4.0

The gem now only compiles under Sprockets, which is what registers the Rails
asset helpers as Sass functions.

6.4.1 turns the stylesheet entry point from an `@import` shim into a Sass
module, and stops suppressing govuk-frontend's deprecation warning about
passing the asset URL helpers by name. In each application:

1. Replace `@import "defra_ruby_template"` with `@use "defra_ruby_template" as *`
   at the top of the stylesheet. Partials it `@import`s keep working as they are.
2. Convert those `@import`s to `@use` too, giving each partial that uses
   govuk-frontend's settings, tools or helpers its own `@use` line.
3. Drop `config.sass.silence_deprecations = ["import"]`.

`@import "defra_ruby_template"` still works, so the steps can be taken
separately, but it keeps the deprecation warning.

### Deprecated colour names

govuk-frontend 6 renamed the colour palette. The old names still resolve, but
each one warns - replace them with the name the warning gives, for example
`govuk-colour("black", $variant: "tint-95")` for `govuk-colour("light-grey")`.

Adding `pre-brand-colour` to `$govuk-suppressed-warnings` does not silence it:
govuk-frontend 6.4.0 calls an undefined `_should-warn()` in
`helpers/_colour.scss`, which Sass falls back to treating as a plain CSS
function, so the suppression check is always true.

## Upgrading from 5.x

1. Move the application to a Dart Sass pipeline (see above).
2. Update `govuk_design_system_formbuilder` to `~> 6.4.0`.
3. Replace the contents of the `:header_content` slot (see below).
4. Check any application stylesheet or markup using classes govuk-frontend 6
   removed - `govuk-template--rebranded`, `govuk-header__content`,
   `govuk-header__link`, `govuk-header__service-name`,
   `govuk-header__navigation*`, `govuk-header__menu-button` and
   `govuk-header__link--homepage`.

### Service navigation

govuk-frontend 6 removed the service name and navigation from the header
component. `govuk-service-navigation` replaces them and renders as a sibling of
the header rather than inside it.

The `:header_content` slot is kept under its existing name - all six consuming
applications fill it - but it has moved to that position, and the classes
applications used to put in it no longer exist. Fill it with service navigation
markup instead:

```erb
<% content_for :header_content do %>
  <section aria-label="Service information"
           class="govuk-service-navigation"
           data-module="govuk-service-navigation">
    <div class="govuk-width-container">
      <div class="govuk-service-navigation__container">
        <span class="govuk-service-navigation__service-name">
          <%= link_to t(:global_proposition_header),
                      main_app.root_path,
                      class: "govuk-service-navigation__link" %>
        </span>
      </div>
    </div>
  </section>
<% end %>
```

## Updating the govuk-frontend

To update to the latest govuk-frontend files:

```bash
npm install govuk-frontend@<version> --save
```

```bash
bundle exec rake
```

`rake` wipes and re-vendors everything under `vendor/assets`, so files that
govuk-frontend has stopped shipping are removed rather than left behind. It also
writes three files that are generated rather than copied:

| File | Generated from |
|------|----------------|
| `vendor/assets/stylesheets/defra_ruby_template.scss` | the entry point applications load |
| `vendor/assets/javascripts/defra_ruby_template_supported.js` | the inline script in govuk-frontend's `template.njk` |
| `vendor/assets/assets/manifest.json.erb` | govuk-frontend's `manifest.json`, with its icon paths rewritten to `asset_path` |

Then:

1. Re-render govuk-frontend's `dist/govuk/template.njk` and port any changes into
   `app/views/layouts/defra_ruby_template.html.erb`.
2. Update [`DefraRubyTemplate::VERSION`](lib/defra_ruby_template/version.rb) to
   match the govuk-frontend [version](https://github.com/alphagov/govuk-frontend/tags).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DEFRA/defra-ruby-template.
