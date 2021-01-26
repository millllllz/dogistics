defmodule Dogistics.Legs.Leg do
  use Ecto.Schema
  import Ecto.Changeset

  schema "legs" do
    belongs_to(:run, Dogistics.Runs.Run)
    belongs_to(:end_point, Dogistics.Points.Point, foreign_key: :end_point_id)
    belongs_to(:start_point, Dogistics.Points.Point, foreign_key: :start_point_id)

    many_to_many(:dogs, Dogistics.Dogs.Dog, join_through: "dogs_legs")

    timestamps()
  end

  @doc false
  def changeset(leg, attrs \\ %{}) do
    leg
    |> cast(attrs, [])
    |> maybe_put_dogs(attrs)
  end

  def maybe_put_dogs(changeset, %{"dogs" => dogs}) do
    dogs =
      dogs
      |> Map.keys()
      |> Dogistics.Dogs.list_dogs_by_id()

    Ecto.Changeset.put_assoc(changeset, :dogs, dogs)
  end

  def maybe_put_dogs(changeset, _), do: changeset
end
