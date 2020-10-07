defmodule Jeopardy.Repo do
  use Ecto.Repo,
    otp_app: :jeopardy,
    adapter: Ecto.Adapters.Postgres

  defoverridable [get: 2, get: 3]

  def get(query, id, opts \\ []) do
    super(query, id, opts)
  rescue
    Ecto.Query.CastError -> nil
  end
end
