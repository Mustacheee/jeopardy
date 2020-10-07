defmodule Jeopardy.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  alias Jeopardy.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "credentials" do
    field :email, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
    |> IO.inspect
  end
end
