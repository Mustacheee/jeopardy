defmodule JeopardyWeb.GameController do
  use JeopardyWeb, :controller

  alias Jeopardy.Games
  alias Jeopardy.Games.Game

  action_fallback JeopardyWeb.FallbackController

  def index(conn, _params) do
    games = Games.list_games()
    render(conn, "index.json", games: games)
  end

  def create(%Plug.Conn{assigns: %{current_user: %{id: user_id}}} = conn, %{"game" => game_params}) do
    with {:ok, %Game{} = game} <- Games.create_game(Map.put(game_params, "user_id", user_id)) do
      conn
      |> put_status(:created)
      |> render("show.json", game: game)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    render(conn, "show.json", game: game)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Games.get_game!(id)

    with {:ok, %Game{} = game} <- Games.update_game(game, game_params) do
      render(conn, "show.json", game: game)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Games.get_game!(id)

    with {:ok, %Game{}} <- Games.delete_game(game) do
      send_resp(conn, :no_content, "")
    end
  end
end
