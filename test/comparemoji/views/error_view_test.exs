defmodule Comparemoji.ErrorViewTest do
  use Comparemoji.ConnCase, async: true

  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(Comparemoji.ErrorView, "404.html", []) == "Not Found"
  end

  test "renders 500.html" do
    assert render_to_string(Comparemoji.ErrorView, "500.html", []) == "Something went wrong"
  end
end
