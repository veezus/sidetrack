config_file = File.join(Rails.root, 'config/config.yml')

raise "Missing configuration file config/config.yml" unless File.exists?(config_file)

AppConfig = YAML.load_file(config_file)[Rails.env]