defmodule JeopardyWeb.CategoryController do
  use JeopardyWeb, :controller

  alias Jeopardy.Accounts.User
  alias Jeopardy.Games
  alias Jeopardy.Games.Category

  action_fallback JeopardyWeb.FallbackController

  def index(conn, _params) do
    categories = Games.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def create(%Plug.Conn{assigns: %{current_user: %User{id: user_id}}} = conn, %{"category" => category_params, "game_id" => game_id}) do
    category_params = category_params
      |> Map.put("user_id", user_id)
      |> Map.put("game_id", game_id)

    with {:ok, %Category{} = category} <- Games.create_category(category_params) do
      conn
      |> put_status(:created)
      |> render("show.json", category: category)
    end
  end

  def create(conn, category_params) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(JeopardyWeb.ErrorView)
    |> render("missing_param.json", params: category_params)
  end

  def show(conn, %{"id" => id}) do
    category = Games.get_category!(id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Games.get_category!(id)

    with {:ok, %Category{} = category} <- Games.update_category(category, category_params) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Games.get_category!(id)

    with {:ok, %Category{}} <- Games.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
