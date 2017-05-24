require 'sinatra'

class PersonController < Sinatra::Base
  get "/me" do
    "Hello, World!"
  end

  get "/:id" do
    "Individual person by ID = #{params[:id]}"
  end
end