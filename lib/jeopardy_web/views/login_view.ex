defmodule JeopardyWeb.LoginView do
  use JeopardyWeb, :view
  alias JeopardyWeb.GameView

  def render("show.json", %{token: token, user: user}) do
    %{
      userData: %{
        email: user.email,
        firstName: user.first_name,
        lastName: user.last_name,
        username: user.username,
      },
      status: "success",
      token: token,
    }
  end

  def render("error.json", %{message: message}) do
    %{
      message: message,
      status: "failed"
    }
  end
end
