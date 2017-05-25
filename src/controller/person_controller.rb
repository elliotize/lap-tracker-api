require 'sinatra'
require 'json'

class PersonController < BaseController
  set :logging, true

  get "/" do
    'stuff'
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
