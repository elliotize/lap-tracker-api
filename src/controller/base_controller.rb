require_relative '../app_config'

require 'sinatra'

class BaseController < Sinatra::Base
  use Rack::Session::Cookie, {
      key: 'rack.session',
      path: '/',
      secret: '637DE9EF-A278-46D1-8351-F0D7F1175D5F'
  }

  config = AppConfig.load
  # TODO: Single config thing someday
  OmniAuth.config.full_host = config.oauth_redirect_uri

  # RESUME HERE
  begin
    @request.env['HTTPS'] = 'on'
    OmniAuth.config.ssl = true
    OmniAuth.ssl = true
  rescue => e
    $stderr.puts e.message
  end

  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }

  use OmniAuth::Builder do
    options = {
      scope: 'userinfo.email,userinfo.profile,plus.me',
      approval_prompt: 'auto',
      redirect_uri: "#{config.oauth_redirect_uri}/auth/google_oauth2/callback",
    }

    # Certified Hackathon Quality - Peter Drake
    # TONOTDO: Release to prod.
    if RUBY_PLATFORM =~ /darwin/
      OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    end

    provider :google_oauth2, config.oauth_key, config.oauth_password, options
  end

  helpers do
    def current_user
      session[:email].gsub('@acquia.com','')
    end

    def logger
      request.logger
    end
  end

  get '/auth/:provider/callback' do
    unless request.env['omniauth.auth']['info']['email'].to_s =~ /@acquia.com$/
      redirect '/auth/failure'
    end

    session[:authenticated] = true
    session[:email] = request.env['omniauth.auth']['info']['email']
    session[:name] = request.env['omniauth.auth']['info']['name']
    redirect '/me'
  end

  get '/auth/failure' do
    erb "<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"
  end

  get '/auth/:provider/deauthorized' do
    erb "#{params[:provider]} has deauthorized this app."
  end

  error do
    e = request.env['sinatra.error']
    logger.error(e.backtrace.join("\n"))
    'Application error'
  end

  def require_valid_acquia_user!
    unless session[:authenticated] || request.path =~ %r{^/login|^/auth}
      redirect '/login'
    end
  end

  get '/login' do
    redirect '/auth/google_oauth2'
  end

  get '/logout' do
    session[:authenticated] = false
    session[:email] = false
    session[:name] = false
    redirect '/'
  end
end