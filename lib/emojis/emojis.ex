defmodule Comparemoji.Emojis do
  @moduledoc false
  alias Comparemoji.Emojis.Data

  def find_and_replace(text, opts) do
    text
    |> String.graphemes()
    |> Enum.reverse()
    |> find_emojis()
    |> replace_in_text(text, opts)
  end

  defp replace_in_text(emojis, text, platform: platform) do
    emojis
    |> Enum.reduce(text, fn emoji, text ->
      replacement =
        Map.get(emoji.images, platform)
        |> case do
          nil ->
            "?"

          image64 ->
            "<img class=\"emoji " <>
              to_string(platform) <>
              "\" src=\"" <> image64 <> "\" alt=\"" <> emoji.description <> "\" />"
        end

      text
      |> String.replace(emoji.unicode, replacement)
    end)
  end

  defp find_emojis(graphemes, results \\ [])

  defp find_emojis([], results), do: Enum.uniq(results)

  defp find_emojis([grapheme | graphemes], results) do
    Data.lookup(grapheme)
    |> case do
      nil ->
        find_emojis(graphemes, results)

      emoji ->
        find_emojis(graphemes, [emoji | results])
    end
  end
end
