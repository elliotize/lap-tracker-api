require 'sinatra'
require 'json'

class EventController < Sinatra::Base

  set :logging, true

  post "/event" do
    content_type :json
    event_id = Event.insert(params) || halt(400, {}.to_json)
    event = Event[event_id]
    event.to_hash.to_json
  end

  get "/event/:id" do
    content_type :json
    event = Event[params[:id]] || halt(404, {}.to_json)
    event.to_hash.to_json
  end
end
