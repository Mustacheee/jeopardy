defmodule Jeopardy.Games.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jeopardy.Games.Game
  alias Jeopardy.Accounts.User

  @derive {Jason.Encoder, only: [:id, :name]}

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
end
