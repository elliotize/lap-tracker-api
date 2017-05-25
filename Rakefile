require 'rake'
require 'sequel'

require_relative 'src/app_config'

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel"
    config = AppConfig.instance
    Sequel.extension :migration
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(config.db, "src/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(config.db, "src/migrations")
    end
  end
  
  desc 'Populate the database with dummy data'
  task 'populate' do
  require 'securerandom'
    config = AppConfig.instance
    face_id = SecureRandom.uuid
    Person.insert(
      first_name: 'John',
      last_name: 'Smith',
      email: 'john.smith@example.com',
      face_id: face_id
    )
    Event.insert(
       face_id: face_id,
       location: 'A',
       timestamp: Time.now
    )
  end
end

# Run the server with shotgun for development
desc "Start the server for development"
task "run", [:port] do |t, args|
  ENV['RACK_ENV'] = 'dev'
  default_port = "9292"
  host = "localhost"

  port_arg = args.port
  port = port_arg ? port_arg : default_port

  puts "Start server: http://#{host}:#{port}/"
  start_server_cmd = "bundle exec shotgun --server=thin --host=#{host} config.ru -p #{port}"

  sh start_server_cmd
end
