# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :jeopardy,
  ecto_repos: [Jeopardy.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :jeopardy, JeopardyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qWTczbUks2BVAZswgOREKmPR7tBgkzzRrOqD8Ybe+dO/lbl/h3LPn/XYCVAQlipE",
  render_errors: [view: JeopardyWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Jeopardy.PubSub,
  live_view: [signing_salt: "k22FG4Z9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
