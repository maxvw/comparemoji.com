use Mix.Config

config :comparemoji, Comparemoji.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
