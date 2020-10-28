# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :socket_pictures,
  ecto_repos: [SocketPictures.Repo]

# Configures the endpoint
config :socket_pictures, SocketPicturesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5oaMY+BTH2LXkBcZdlx+s91/aHvhhPgqJOXNhQzvb6ujSX0CQAUtJ9RuvjGD+hPF",
  render_errors: [view: SocketPicturesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SocketPictures.PubSub,
  live_view: [signing_salt: "zp1wGKJb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
