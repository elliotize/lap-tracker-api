require 'require_all'
require 'yaml'
require 'singleton'

class AppConfig
  include Singleton

  def self.load
    file = File.join(__dir__, '..', 'config.yml')
    config = begin
      YAML.load_file(file)
    rescue
      {}
    end
    config_object = instance
    config_object.set_config(config)
    config_object
  end

  def initialize
    @hash = {}
    @db ||= initialize_database
  end

  def set_config(hash = {})
    @hash = hash
  end

  def db
    @db
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
    !is_production? && !is_testing?
  end

  def is_production?
    ENV['RACK_ENV'] == 'production'
  end

  def is_testing?
    ENV['RACK_ENV'] == 'test'
  end

  def database_connection
    case true
    when is_development?
      "sqlite://#{File.join(__dir__, '../database.db')}"
    when is_testing?
      'sqlite::memory:'
    when is_production?
      "mysql2://#{ENV['DB_USER']}:#{ENV['DB_PASS']}@#{ENV['DB_HOST']}/#{ENV['DB_NAME']}"
    else
      raise 'Unknown rack environment'
    end
  end

  def oauth_options
    @hash.fetch('oauth', {})
  end
end
