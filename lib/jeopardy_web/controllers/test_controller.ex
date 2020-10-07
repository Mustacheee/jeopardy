defmodule JeopardyWeb.TestController do
  use JeopardyWeb, :controller

  def index(conn, _params) do
    json(conn, %{test: "thing"});
  end
end
