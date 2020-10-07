defmodule Jeopardy.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Jeopardy.Helpers.ModelValidators, only: [email_validator: 2]

  alias Jeopardy.Accounts.Credential

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields ~w(first_name last_name email)a
  @optional_fields ~w(username)a

  schema "users" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string

    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> email_validator(:email)
    |> unique_constraint(:email)
  end
end
