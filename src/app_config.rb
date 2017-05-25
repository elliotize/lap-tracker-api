require 'require_all'

class AppConfig
  def self.load
    file = File.join(__dir__, '..', 'config.yml')
    new(YAML.load_file(file))
  end

  def initialize(hash = {})
    @hash = hash
    initialize_database
  end

  def db
    @db ||= initialize_database
  end

  def initialize_database
    db = Sequel.connect(database_connection)
    require_all 'src/model/*.rb'
    db
  end

  def oauth_enabled?
    @hash.fetch('enabled', false)
  end

  def oauth_redirect_uri
    oauth_options.fetch('redirect_uri')
  end

  def oauth_key
    oauth_options.fetch('key')
  end

  def oauth_password
    oauth_options.fetch('password')
  end

  private

  def is_development?
    !ENV.key?('DB_HOST')
  end

  def database_connection
    if is_development?
      "sqlite://#{File.join(__dir__, '../database.db')}"
    else
      "mysql2://#{ENV['DB_USER']}:#{ENV['DB_PASS']}@#{ENV['DB_HOST']}/#{ENV['DB_NAME']}"
    end
  end

  def oauth_options
    @hash.fetch('oauth', {})
  end
end
