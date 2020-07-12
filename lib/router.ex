defmodule Comparemoji.Router do
  import Phoenix.LiveView.Router
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Comparemoji.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Comparemoji do
    pipe_through :browser
    live "/", EmojiLive, :index
  end
end
