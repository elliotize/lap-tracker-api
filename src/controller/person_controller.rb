require 'sinatra'
require 'json'
require 'erb'

class PersonController < BaseController
  get '/' do
    leaders = []
    Person.each do |person|
      last_location = '0'
      laps = 0.0
      events = Event.where(face_id: person[:face_id]).order(:timestamp).each do |event|
        if last_location != event.location
          laps = laps + 0.5
          last_location = event.location
        end
      end

      leaders << {
        'first' => person[:first_name],
        'last' => person[:last_name],
        'laps' => laps.to_i
      }

      leaders.sort_by! { |leader| -leader['laps'] }
      rank = 1
      leaders.each do |leader|
        leader['rank'] = rank
        rank += 1
      end
    end
    template = IO.read("#{File.dirname(__FILE__)}/../view/people.html.erb")
    o = Object.new
    o.instance_variable_set(:@leaders, leaders)
    ERB.new(template).result(o.instance_eval { binding })
  end

  get "/me" do
    require_valid_acquia_user!
    content_type :json
    person = Person[1] || halt(404, {}.to_json)
    person.to_hash.to_json
  end

  get "/person/:id" do
    content_type :json
    person = Person[params[:id]] || halt(404, {}.to_json)
    person.to_hash.to_json
  end
end
