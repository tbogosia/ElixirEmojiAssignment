defmodule EmojiWeb.EmojiControllerTest do
  use EmojiWeb.ConnCase

  describe "GET /emojis/:emoji_name" do

    test "tada", %{conn: conn} do
      conn = get(conn, "/emojis/tada")
      response = json_response(conn, 200)
      assert response["unicode"] == "🎉"
    end

    test "sparkles", %{conn: conn} do
      conn = get(conn, "/emojis/sparkles")
      response = json_response(conn, 200)
      assert response["unicode"] == "✨"
    end

    test "empty case", %{conn: conn} do
      conn = get(conn, "/emojis/")
      assert html_response(conn, 404)
    end

  end

end
