defmodule JeopardyWeb.CategoryView do
  use JeopardyWeb, :view
  alias JeopardyWeb.CategoryView

  def render("index.json", %{categories: categories}) do
    %{
      status: "success",
      data: render_many(categories, CategoryView, "category.json")
    }
  end

  def render("show.json", %{category: category}) do
    %{
      status: "success",
      data: render_one(category, CategoryView, "category.json")
    }
  end

  def render("category.json", %{category: category}) do
    %{id: category.id, gameId: category.game_id, name: category.name}
  end
end
