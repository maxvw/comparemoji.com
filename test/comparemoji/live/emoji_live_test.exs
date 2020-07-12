defmodule Comparemoji.PageLiveTest do
  use Comparemoji.ConnCase

  import Phoenix.LiveViewTest

  describe "disconnected" do
    test "renders regular html", %{conn: conn} do
      conn = get(conn, "/")

      assert html_response(conn, 200) =~
               "<title dir=\"ltr\">Compare emojis on different platforms</title>"
    end

    test "processes query parameter", %{conn: conn} do
      {:ok, _page_live, disconnected_html} = live(conn, "/?q=🎈")
      assert disconnected_html =~ "alt=\"balloon\""
    end
  end

  test "search emoji", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert view
           |> element("form")
           |> render_change(%{q: "🦦"}) =~ "alt=\"otter\""
  end

  test "shows emojis for different platforms", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert view |> element(".emoji.apple") |> has_element?()
    assert view |> element(".emoji.google") |> has_element?()
    assert view |> element(".emoji.samsung") |> has_element?()
    assert view |> element(".emoji.facebook") |> has_element?()
    assert view |> element(".emoji.windows") |> has_element?()
  end
end
