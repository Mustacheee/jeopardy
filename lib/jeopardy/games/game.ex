defmodule Jeopardy.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jeopardy.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields ~w(name user_id)a

  schema "games" do
    field :name, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
