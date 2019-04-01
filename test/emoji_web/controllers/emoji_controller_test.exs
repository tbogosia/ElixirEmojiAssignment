defmodule EmojiWeb.EmojiControllerTest do
  use EmojiWeb.ConnCase

  describe "GET /emojis/:emoji_name" do

    test "emojis/sparkles returns a tada emoji", %{conn: conn} do
      conn = get(conn, "/emojis/tada")
      response = json_response(conn, 200)
      assert response["unicode"] == "🎉"
    end

    test "/emojis/sparkles returns a sparkles emoji", %{conn: conn} do
      conn = get(conn, "/emojis/sparkles")
      response = json_response(conn, 200)
      assert response["unicode"] == "✨"
    end

    test "no results returns a 404", %{conn: conn} do
      conn = get(conn, "/emojis/nonehere")
      assert html_response(conn, 404)
    end

    test "/emojis lists all emojis", %{conn: conn} do
      conn = get(conn, "/emojis/")
      response = json_response(conn, 200)
      assert Kernel.length(response) == 845
    end

  end

end
