defmodule JeopardyWeb.UserChannel do
  use JeopardyWeb, :channel
  alias Jeopardy.Games

  def join("user:" <> _user_id, _params, %{assigns: %{user: user}} = socket) do
    games = Games.get_user_games(user)

    {:ok, %{user: user, games: games}, socket}
  end

  def handle_in(event, params, socket) do
    broadcast!(socket, event, params)
    {:reply, {:ok, %{test: "testssss"}}, socket}
  end
end
