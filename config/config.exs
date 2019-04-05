# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :stop_watch, StopWatchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2E1XAlz6A7IEz0HV78nhku5DXyN16A4yNswbXFcrRaI6Tzm9KPxVnk0CZ1NJuy9Y",
  render_errors: [view: StopWatchWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StopWatch.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "SDWVKKkkJiFq5GlS1se3GT0AHOzhUXkX"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
