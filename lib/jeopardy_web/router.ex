defmodule JeopardyWeb.Router do
  use JeopardyWeb, :router
  import JeopardyWeb.Plugs.Authentication

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug :ensure_authenticated
    plug :parse_identity_token
  end

  scope "/api", JeopardyWeb do
    pipe_through :api

    post "/login", LoginController, :login
    resources "/users", UserController, only: [:create]
  end

  scope "/api", JeopardyWeb do
    pipe_through [:api, :authenticated]

    resources "/games", GameController, except: [:new, :edit] do
      resources "/categories", CategoryController, except: [:new, :edit]
    end

    resources "/users", UserController, except: [:create, :new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: JeopardyWeb.Telemetry
    end
  end
end
