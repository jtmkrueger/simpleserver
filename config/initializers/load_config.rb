# APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

Action.session = {
    :username => ENV['USERNAME'],
    :password => ENV['PASSWORD']
  }