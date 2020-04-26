# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# config :phoenix_elixir_dokku,
#   ecto_repos: [PhoenixElixirDokku.Repo]

# Configures the endpoint
config :phoenix_elixir_dokku, PhoenixElixirDokkuWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xJj/tqIjK+mQGm8WpLzoY+HF68PvjweRnVrjvGchE0bSs+RKbDrUPsKFHp+83/mO",
  render_errors: [view: PhoenixElixirDokkuWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixElixirDokku.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger,
  backends: [
    :console
    # {LogstashJson.Console, :json}
    #    LoggerJSON
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  handle_otp_reports: true,
  handle_sasl_reports: true

# log_file = "logs/logger.jsonl"
#
# config :log_manager,
#  filename: log_file,
#  max_reqs_rotate: 100
#
# config :log_rotate,
#  # on_init: {LogManager, :log_rotate_opts, []}
#  filenames: [log_file],
#  # 5 min
#  check_every: 5 * 60 * 1000,
#  # 32 KiB
#  max_log_size: 32 * 1024,
#  num_backups: 9
#
## Important: you have to use :on_init to be able to send to LogManager.Core
## instead of :device here.
# config :logger_json, :backend,
#  on_init: {LogManager, :logger_json_opts, []},
#  metadata: :all,
#  max_buffer: 32,
#  formatter: LoggerJSON.Formatters.MyBasicLogger

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
