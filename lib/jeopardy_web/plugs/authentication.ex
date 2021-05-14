defmodule JeopardyWeb.Plugs.Authentication do
  @moduledoc """
    This plug is to handle authenticating the user based on the 'authorization' header.
  """
  import Plug.Conn
  alias Jeopardy.Accounts
  alias Jeopardy.Accounts.{User}

  # Type of authentication token being used
  @token_type "Bearer"
  def token_type, do: @token_type

  @doc """
    Extract the user based on the authorization token provided.
  """
  @spec parse_identity_token(Plug.Conn.t(), any) :: Plug.Conn.t()
  def parse_identity_token(conn, _opts) do
    user =
      conn
      |> get_req_header("authorization")
      |> extract_token()
      |> case do
        token when is_binary(token) ->
          Accounts.get_user_by_token(token)

        _ ->
          nil
      end

    assign(conn, :current_user, user)
  end

  @doc """
    Ensure that the connection has an authenticated user or else halt.
  """
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

  @spec extract_token(any) :: nil | binary
  def extract_token([value]), do: extract_token(value)

  def extract_token(value) when is_binary(value) and value != "" do
    value
    |> String.split("#{@token_type} ")
    |> case do
      ["", token] ->
        token

      _ ->
        nil
    end
  end

  def extract_token(_), do: nil
end
