defmodule JeopardyWeb.LoginController do
  use JeopardyWeb, :controller
  alias Jeopardy.Accounts

  action_fallback JeopardyWeb.FallbackController

  def login(conn, %{"email" => email, "password" => _password}) do
    params = [email: email]
    token =
      params
      |> Accounts.get_user_by()
      |> IO.inspect()
      |> case do
        %{credential: %{id: token}} ->
          token
        _ -> nil
      end

    render(conn, "show.json", token: token)
  end

  def login(conn, _params) do
    # user = Accounts.get_user_by(%{"email" => email})
    render(conn, "show.json", user: %{})
  end
end
