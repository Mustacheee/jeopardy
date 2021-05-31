defmodule JeopardyWeb.GameChannel do
  use Phoenix.Channel

  alias Jeopardy.Games
  alias Jeopardy.Games.{Game, GameConfig}

  def join("game:" <> game_id, params, socket) do
    game_id
    |> Games.get_game()
    |> case do
      %Game{} = game ->
        {:ok, game, socket |> assign(:game, game)}

      _ ->
        {:error, :not_found}
    end
  end

  def handle_in("category_details" = event, %{"categoryId" => category_id}, socket) do
    category = Games.get_category_details(category_id)
    questions = Map.get(category, :questions)
    {:reply, {:ok, %{category: category, event: event, questions: questions}}, socket}
  end

  def handle_in(event, params, socket) do
    # broadcast!(socket, event, params)
    {:reply, {:ok, %{test: "testssss"}}, socket}
  end
end
