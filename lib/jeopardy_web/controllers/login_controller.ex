defmodule JeopardyWeb.LoginController do
  use JeopardyWeb, :controller
  alias Jeopardy.Accounts
  alias Jeopardy.Accounts.User
  alias JeopardyWeb.Plugs.Authentication

  action_fallback JeopardyWeb.FallbackController

  def login(conn, %{"email" => email, "password" => _password}) do
    params = [email: email]

    params
    |> Accounts.get_user_by()
    |> case do
      %{credential: %{id: token}} = user ->
        render(conn, "show.json", token: token, user: user)

      _ ->
        render(conn, "error.json", message: "Invalid username or password.")
    end
  end

  def login(conn, %{"apiToken" => "#{unquote(Authentication.token_type)} " <> apiToken}) do
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
    conn
    |> put_status(:bad_request)
    |> put_view(JeopardyWeb.ErrorView)
    |> render(:"400")
  end
end
