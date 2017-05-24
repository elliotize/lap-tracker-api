defmodule AppName.Router do
  use AppName.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AppName do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/test", PageController, :cool_story_bro
  end

  # Other scopes may use custom stacks.
  # scope "/api", AppName do
  #   pipe_through :api
  # end
end
