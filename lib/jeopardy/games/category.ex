defmodule Jeopardy.Games.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jeopardy.Games.Game
  alias Jeopardy.Accounts.User

  # @derive {Jason.Encoder, only: [:id, :name, :game_id]}
  # use Jeopardy.CamelCaseEncoder, [encode_opts: [only: [:id, :name, :game_id], for: __MODULE__]]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields ~w(name game_id user_id)a

  schema "categories" do
    field :name, :string

    belongs_to :game, Game
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

  defimpl Jason.Encoder, for: Jeopardy.Games.Category do
    def encode(list, opts) do
      list
      |> Map.take([:id, :name, :game_id])
      |> Enum.map(fn {key, value} ->
        {Inflex.camelize(to_string(key), :lower), value}
      end)
      |> Enum.into(%{})
      |> Jason.Encode.map(opts)
    end
  end
end
