defmodule Jeopardy.Games.Question do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jeopardy.Games.Category

  @derive {Jason.Encoder, only: [:id, :text, :answer]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields ~w(answer text category_id)a

  schema "questions" do
    field :answer, :string
    field :text, :string

    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
