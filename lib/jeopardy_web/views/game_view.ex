defmodule JeopardyWeb.GameView do
  use JeopardyWeb, :view
  alias JeopardyWeb.GameView

  def render("index.json", %{games: games}) do
    %{
      status: "success",
      data: render_many(games, GameView, "game.json")
    }
  end

  def render("show.json", %{game: game}) do
    %{
      status: "success",
      data: render_one(game, GameView, "game.json")
    }
  end

  def render("game.json", %{game: game}) do
    %{
      id: game.id,
      name: game.name,
      categories: Map.get(game, :categories, []),
      config: Map.get(game, :config, nil)
    }
  end
end
