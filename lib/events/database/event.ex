defmodule Events.Database.Event do
  use Ecto.Schema
  import Ecto.Changeset


  schema "events" do
    field :allDay, :boolean, default: false
    field :end, :utc_datetime
    field :start, :utc_datetime
    field :title, :string
    field :color, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :allDay, :start, :end, :color])
    |> validate_required([:title, :allDay, :start, :end, :color])
  end
end
