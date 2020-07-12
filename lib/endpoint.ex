defmodule Comparemoji.Endpoint do
  use Phoenix.Endpoint, otp_app: :comparemoji

  @session_options [
    store: :cookie,
    key: "cmsess",
    signing_salt: "somesigningsalt"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Static,
    at: "/",
    from: :comparemoji,
    gzip: false,
    only: ~w(css js favicon.ico robots.txt)

  plug Plug.RequestId

  plug Plug.Parsers,
    parsers: [:urlencoded],
    pass: ["*/*"]

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session, @session_options
  plug Comparemoji.Router
end
