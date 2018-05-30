# EventEx - 

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Routes

All the routes can be found by the `mix phx.routes` command

```elixir
$ mix phx.routes
 page_path  GET     /                EventsWeb.PageController :index
 page_path  GET     /submit          EventsWeb.PageController :submit
event_path  GET     /api/events      EventsWeb.EventController :index
event_path  GET     /api/events/:id  EventsWeb.EventController :show
event_path  POST    /api/events      EventsWeb.EventController :create
event_path  PATCH   /api/events/:id  EventsWeb.EventController :update
            PUT     /api/events/:id  EventsWeb.EventController :update
event_path  DELETE  /api/events/:id  EventsWeb.EventController :delete

```

## TODO

* Add authentication
* Finalize Front-End CRUD functionality
* Add individually generated event page. 


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
