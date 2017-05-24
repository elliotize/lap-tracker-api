require 'sequel'
require 'sinatra'

Sequel::Model.db = Sequel.sqlite

require_relative '../src/load.rb'

