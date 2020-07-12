defmodule Comparemoji.LayoutView do
  use Phoenix.HTML

  use Phoenix.View,
    root: "lib/templates",
    namespace: Comparemoji

  alias Comparemoji.Router.Helpers, as: Routes
end
