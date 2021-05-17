defmodule JeopardyWeb.AuthenticatedSocket do
  use Phoenix.Socket
  alias JeopardyWeb.Plugs.Authentication
  alias Jeopardy.Accounts

  channel "user:*", JeopardyWeb.UserChannel
  channel "game:*", JeopardyWeb.GameChannel

  @impl true
  def connect(%{"apiToken" => apiToken}, socket, _connect_info) do
    apiToken
    |> Authentication.extract_token()
    |> case do
      token when is_binary(token) ->
        user = Accounts.get_user_by_token(token)

        {:ok, assign(socket, :user, user)}
      _ ->
        :error
    end
  end

  @impl true
  def connect(_params, _socket, _connect_info), do: :error

  @impl true
  def id(socket), do: "user_socket:#{socket.assigns.user.id}"
end
