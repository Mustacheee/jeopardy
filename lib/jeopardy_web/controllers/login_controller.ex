defmodule JeopardyWeb.LoginController do
  use JeopardyWeb, :controller
  alias Jeopardy.Accounts
  alias Jeopardy.Accounts.User

  action_fallback JeopardyWeb.FallbackController

  def login(conn, %{"email" => email, "password" => _password}) do
    params = [email: email]

    params
    |> Accounts.get_user_by()
    |> IO.inspect()
    |> case do
      %{credential: %{id: token}} = user ->
        render(conn, "show.json", token: token, user: user)

      _ ->
        nil
        render(conn, "error.json", message: "Invalid username or password.")
    end
  end

  def login(conn, %{"apiToken" => apiToken}) do
    apiToken
    |> Accounts.get_credential()
    |> Accounts.get_user_from_credential()
    |> case do
      %User{} = user ->
        render(conn, "show.json", token: apiToken, user: user)

      _ ->
        render(conn, "error.json", message: "Invalid username or password.")
    end
  end

  def login(conn, _params) do
    # user = Accounts.get_user_by(%{"email" => email})
    render(conn, "show.json", user: %{})
  end
end
