defmodule Comparemoji.Emojis.Emoji do
  @moduledoc false
  @derive [Jason.Encoder]
  defstruct ~w{
    code
    unicode
    description
    images
  }a
end
