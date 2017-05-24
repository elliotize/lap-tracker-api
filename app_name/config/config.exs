# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :app_name,
  ecto_repos: [AppName.Repo]

# Configures the endpoint
config :app_name, AppName.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tv50iV2TFwe9IEmfe8fQsuz6UzEU2HtfRksdOdVdeeMezbvy0tfnJzKF2EWpBjR9",
  render_errors: [view: AppName.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AppName.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
