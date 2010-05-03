# APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

APP_CONFIG = {
    :username => ENV['USERNAME'],
    :password => ENV['PASSWORD']
  }