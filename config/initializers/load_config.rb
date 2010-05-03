# APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

action_controller.session = {
    :username => ENV['USERNAME'],
    :password => ENV['PASSWORD']
  }