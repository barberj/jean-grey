# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :splurty,
  ecto_repos: [Splurty.Repo]

# Configures the endpoint
config :splurty, Splurty.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7uToh/aX4lFRdAyUCOgY8xCIsJ8En7EQqHiqU6pQil3b0Wz1ZADUYelQsblCoxb2",
  render_errors: [view: Splurty.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Splurty.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
