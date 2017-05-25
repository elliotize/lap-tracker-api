class AppConfig
  def self.load
    file = File.join(__dir__, '..', 'config.yml')
    new(YAML.load_file(file))
  end

  def initialize(hash)
    @hash = hash
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

  def oauth_options
    @hash.fetch('oauth', {})
  end
end
