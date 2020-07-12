use Mix.Config

config :comparemoji, Comparemoji.Endpoint,
  url: [host: "localhost", port: 4000],
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css)$",
      ~r"lib/(live|views)/.*(ex)$",
      ~r"lib/templates/.*(eex)$"
    ]
  ],
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]
