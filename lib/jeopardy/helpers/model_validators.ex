defmodule Jeopardy.Helpers.ModelValidators do
  import Ecto.Changeset, only: [validate_format: 4]

  def email_validator(%Ecto.Changeset{} = changeset, field) do
    changeset
    |> validate_format(field, ~r/@/, message: "invalid email format")
  end
end
