defmodule EmojiWeb.PageController do
  use EmojiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
