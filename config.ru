require 'sequel'

# DB_HOST
# DB_USER
# DB_PASS
# DB_NAME

db = File.join(__dir__, 'filename.db')
Sequel::Model.db = Sequel.sqlite(db)

require_relative 'src/load.rb'

run PersonController
