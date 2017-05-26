require 'sinatra'
require 'json'
require 'pry'

class EventController < BaseController
  before do
    if request.request_method == "POST"
      body_parameters = request.body.read
      params.merge!(JSON.parse(body_parameters))
    end
  end

  get "/events" do
    content_type :json
    events = Event.all || []
    events.map!(&:to_hash)
    events.to_json
  end

  get "/event/:id" do
    content_type :json
    event = Event[params[:id]] || halt(404, {error: 'Not Found'}.to_json)
    event.to_hash.to_json
  end

  post "/event" do
    content_type :json
    event_id = begin
      Event.insert(
        face_id: params['face_id'],
        timestamp: params['timestamp'],
        location: params['location']
      ) || halt(400, {}.to_json)
    rescue Sequel::ForeignKeyConstraintViolation
      halt(400, {error: 'Bad Request'}.to_json)
    end
    event = Event[event_id]
    event.to_hash.to_json
  end
end
