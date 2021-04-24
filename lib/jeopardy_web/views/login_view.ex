defmodule JeopardyWeb.LoginView do
  use JeopardyWeb, :view
  alias JeopardyWeb.GameView

  def render("show.json", %{token: token}) do
    %{token: token}
  end
end
