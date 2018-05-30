defmodule Events.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :allDay, :boolean, default: false, null: false
      add :start, :utc_datetime
      add :end, :utc_datetime
      add :color, :string

      timestamps()
    end

  end
end
