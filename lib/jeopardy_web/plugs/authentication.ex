defmodule JeopardyWeb.Plugs.Authentication do
  @moduledoc """
    This plug is to handle authenticating the user based on the 'authorization' header.
  """
  import Plug.Conn
  alias Jeopardy.Accounts
  alias Jeopardy.Accounts.{User}

  # Type of authentication token being used
  @token_type "Bearer"

  @doc """
    Extract the user based on the authorization token provided.
  """
  @spec parse_identity_token(Plug.Conn.t(), any) :: Plug.Conn.t()
  def parse_identity_token(conn, _opts) do
    user =
      conn
      |> extract_token
      |> case do
        token when is_binary(token) ->
          get_user_by_token(token)

        _ ->
          nil
      end

    assign(conn, :current_user, user)
  end

  def ensure_authenticated(conn, _opts) do
    case conn do
      %{assigns: %{current_user: %User{}}} ->
        conn

      _ ->
        conn
        |> put_status(:forbidden)
        |> Phoenix.Controller.put_view(JeopardyWeb.ErrorView)
        |> Phoenix.Controller.render(:"403")
        |> halt()
    end
  end

  defp extract_token(conn) do
    conn
    |> get_req_header("authorization")
    |> case do
      [header_value] ->
        header_value
        |> String.split("#{@token_type} ")
        |> case do
          ["", token] ->
            token

          _ ->
            nil
        end

      _ ->
        nil
    end
  end

  defp get_user_by_token(token) do
    token
    |> Accounts.get_credential()
    |> Accounts.get_user_from_credential()
  end
end
