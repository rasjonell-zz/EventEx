defmodule EventsWeb.PageController do
  use EventsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def submit(conn, _params) do
    render conn, "submit.html"
  end

end
