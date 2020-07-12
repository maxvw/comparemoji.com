defmodule Comparemoji.EmojiLive do
  @moduledoc false

  import Phoenix.HTML
  import Phoenix.LiveView.Helpers

  alias Comparemoji.Emojis

  use Phoenix.LiveView,
    container: {:main, class: "container"},
    layout: {Comparemoji.LayoutView, "messenger.html"}

  def mount(%{"q" => query}, _session, socket) do
    query = sanitize_query(query)
    {:ok, assign(socket, query: query)}
  end

  def mount(_params, _session, socket) do
    query = "Hello! 👋 🎈 🦦"
    {:ok, assign(socket, query: query)}
  end

  def handle_event("preview", %{"q" => query}, socket) do
    query = sanitize_query(query)

    {:noreply, assign(socket, query: query)}
  end

  defp sanitize_query(query) do
    query
    |> String.trim()
    |> String.slice(0, max_text_size())
    |> HtmlSanitizeEx.strip_tags()
  end

  defp formatted(text, opts) do
    Emojis.find_and_replace(text, opts)
  end

  defp max_text_size, do: 50

  defp supported_platforms do
    [
      {:apple, "Apple"},
      {:google, "Google"},
      {:samsung, "Samsung"},
      {:facebook, "Facebook"},
      {:windows, "Windows"}
    ]
  end
end
