# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :library,
  ecto_repos: [Library.Repo]

# Configures the endpoint
config :library, LibraryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DVpfucyDEm58Gc8lV+Wv2gqoisUAdNpzR+TkFNgBRh/GVlNr5ayjLMhCMaE5KYsa",
  render_errors: [view: LibraryWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Library.PubSub,
  live_view: [signing_salt: "QPmC8jAp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :waffle, storage: Waffle.Storage.Local

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
