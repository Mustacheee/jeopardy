defmodule Jeopardy.Games.GameConfig do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jeopardy.Games.Game

  @required_fields ~w(column_count qs_per_category game_id)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_configs" do
    field :column_count, :integer
    field :qs_per_category, :integer

    belongs_to :game, Game

    timestamps()
  end

  @doc false
  def changeset(game_config, attrs) do
    game_config
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
