defmodule JeopardyWeb.GameChannel do
  use Phoenix.Channel;

  alias Jeopardy.Games
  alias Jeopardy.Games.Game

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

  def handle_in(event, params, socket) do
    IO.inspect(event)
    IO.inspect(params)
    IO.inspect(socket)

    broadcast!(socket, event, params)
    {:reply, {:ok, %{test: "testssss"}}, socket}
  end
end
