defmodule JeopardyWeb.UserChannel do
  use JeopardyWeb, :channel
  alias Jeopardy.Games

  def join("user:" <> _user_id, _params, %{assigns: %{user: user}} = socket) do
    games = Games.get_user_games(user)

    {:ok, %{user: user, games: games}, socket}
  end
end
