require 'sequel'
require 'sinatra'

require_relative 'src/app_config'
require_relative 'src/load.rb'

# DB_HOST
# DB_USER
# DB_PASS
# DB_NAME

AppConfig.new

run PersonController
