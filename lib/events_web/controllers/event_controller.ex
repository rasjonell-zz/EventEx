defmodule EventsWeb.EventController do
  use EventsWeb, :controller

  alias Events.Database
  alias Events.Database.Event

  action_fallback EventsWeb.FallbackController

  def index(conn, _params) do
    events = Database.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => %{"title" => title, "start" => start, "end" => finish, "color" => color}}) do
    {:ok, start_date, _} = start  |> DateTime.from_iso8601()
    {:ok, end_date, _}   = finish |> DateTime.from_iso8601()
    
    event_params = %{
      title: title,
      start: start_date,
      end: end_date,
      color: color
    }
    
    with {:ok, %Event{} = event} <- Database.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Database.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Database.get_event!(id)

    with {:ok, %Event{} = event} <- Database.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Database.get_event!(id)
    with {:ok, %Event{}} <- Database.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
