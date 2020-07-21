defmodule Comparemoji.EmojiLive do
  @moduledoc false

  import Phoenix.HTML
  import Phoenix.LiveView.Helpers

  alias Comparemoji.Emojis

  use Phoenix.LiveView,
    container: {:main, class: "container"},
    layout: {Comparemoji.LayoutView, "messenger.html"}

  def mount(%{"q" => query}, _session, socket) do
    {:ok, set_query(socket, query), temporary_assigns: [emojis: []]}
  end

  def mount(_params, _session, socket) do
    query = "Hello! 👋 🎈 🦦"
    {:ok, set_query(socket, query)}
  end

  def handle_event("preview", %{"q" => query}, socket) do
    {:noreply, set_query(socket, query)}
  end

  defp set_query(socket, query) do
    query = sanitize_query(query)
    prev_emojis = socket.assigns[:prev_emojis] || []

    new_emojis =
      Emojis.find(query)
      |> Enum.filter(&(!Enum.member?(prev_emojis, &1.unicode)))

    prev_emojis =
      new_emojis
      |> Enum.reduce(prev_emojis, fn emoji, list ->
        [emoji.unicode | list]
      end)

    assign(socket, query: query, prev_emojis: prev_emojis, emojis: new_emojis)
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
