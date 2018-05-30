defmodule Events.DatabaseTest do
  use Events.DataCase

  alias Events.Database

  describe "events" do
    alias Events.Database.Event

    @valid_attrs %{allDay: true, end: "2010-04-17 14:00:00.000000Z", start: "2010-04-17 14:00:00.000000Z", title: "some title"}
    @update_attrs %{allDay: false, end: "2011-05-18 15:01:01.000000Z", start: "2011-05-18 15:01:01.000000Z", title: "some updated title"}
    @invalid_attrs %{allDay: nil, end: nil, start: nil, title: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Database.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Database.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Database.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Database.create_event(@valid_attrs)
      assert event.allDay == true
      assert event.end == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert event.start == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert event.title == "some title"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Database.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Database.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.allDay == false
      assert event.end == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert event.start == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert event.title == "some updated title"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Database.update_event(event, @invalid_attrs)
      assert event == Database.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Database.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Database.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Database.change_event(event)
    end
  end
end
