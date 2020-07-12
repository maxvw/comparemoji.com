use Mix.Config

config :phoenix, :json_library, Jason

config :comparemoji, Comparemoji.Endpoint,
  pubsub_server: Comparemoji.PubSub,
  secret_key_base: "g3FhYQDaa5zzhvGCbac+eIQfiuAe61IhScmnjafCNpjoGZ3Xwxsq7hk/e94TFRhH",
  live_view: [signing_salt: "G431L/PQPet/U1Exrp6NQjX+UvqeWkMBtMrHorQoH3nysgNKNZmLRNHT0RnZKKpK"]

import_config "#{Mix.env()}.exs"
