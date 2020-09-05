defmodule Comparemoji.Emojis do
  @moduledoc false
  alias Comparemoji.Emojis.Emoji
  alias Comparemoji.Emojis.Data

  def find(text) do
    text
    |> String.graphemes()
    |> Enum.map(&Data.lookup/1)
    |> Enum.filter(&(!is_nil(&1)))
    |> Enum.uniq()
  end

  def replace([], text, _opts), do: text

  def replace([%Emoji{} = emoji | emojis], text, [platform: platform] = opts) do
    image =
      emoji.images
      |> Map.get(platform)
      |> case do
        nil ->
          "?"

        _image ->
          "<a href=\"https://emojipedia.org/#{emoji.unicode}\" rel=\"external\" class=\"emoji #{
            platform
          } #{emoji.unicode}\">#{emoji.description}</a>"
      end

    replace(emojis, text |> String.replace(emoji.unicode, image), opts)
  end

  def replace(_unknown, text, _opts), do: text

  def find_and_replace(text, opts) do
    text
    |> find()
    |> replace(text, opts)
  end
end
