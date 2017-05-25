require 'sequel'
require 'sinatra'
require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require_relative '../src/app_config'
config = AppConfig.instance
Sequel.extension :migration

require_relative '../src/load.rb'

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

# For RSpec 2.x and 3.x
RSpec.configure do |c|
  c.include RSpecMixin
  c.before(:each) do
    Sequel::Migrator.run(config.db, File.join(__dir__, '../src/migrations'))
  end
end
