defmodule JeopardyWeb.UserView do
  use JeopardyWeb, :view
  alias JeopardyWeb.UserView

  def render("index.json", %{users: users}) do
    %{
      status: "success",
      data: render_many(users, UserView, "user.json")
    }
  end

  def render("show.json", %{user: user}) do
    %{
      status: "success",
      data: render_one(user, UserView, "user.json")
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      firstName: user.first_name,
      lastName: user.last_name,
      email: user.email,
    }
  end

  def render("missing_param.json", %{params: params}) do
    %{
      error: "Missing Params",
      params: params,
    }
  end
end
