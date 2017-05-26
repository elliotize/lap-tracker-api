require 'sequel'
require 'sinatra'

require_relative 'src/app_config'
require_relative 'src/load.rb'

AppConfig.instance

use PersonController
run EventController
