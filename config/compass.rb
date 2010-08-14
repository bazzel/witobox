# This configuration file works with both the Compass command line tool and within Rails.
# Require any additional compass plugins here.
project_type = :rails
project_path = Compass::AppIntegration::Rails.root
# Set this to the root of your project when deployed:
http_path = "/"
# Do not set css_dir, let Hassle take care of it and get compiled css files from public/stylesheets.
# css_dir = "public/stylesheets/compiled"
sass_dir = "app/stylesheets"
environment = Compass::AppIntegration::Rails.env
# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true
# Specify template_location to make Hassle look in the sass_dir.
Sass::Plugin.options[:template_location] = sass_dir