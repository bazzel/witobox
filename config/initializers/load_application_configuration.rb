APP_CONFIG = YAML::load(ERB.new(IO.read(File.join(RAILS_ROOT, 'config', 'application.yml'))).result)[Rails.env]