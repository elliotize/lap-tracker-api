defmodule AppName.PageController do
  use AppName.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def cool_story_bro(conn, _params) do
    render conn, "cool.html"
  end
end
