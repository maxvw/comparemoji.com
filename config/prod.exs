use Mix.Config

config :comparemoji, Comparemoji.Endpoint,
  server: true,
  http: [port: 4000],
  url: [host: "comparemoji.com", schema: "https", port: 443]
