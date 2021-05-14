defmodule JeopardyWeb.UserChannel do
  use JeopardyWeb, :channel

  def join(conn, params, socket) do
    IO.inspect(params)

    {:ok, %{test: "123"}, socket}
  end
end
