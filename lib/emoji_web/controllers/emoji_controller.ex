defmodule EmojiWeb.EmojiController do
  use EmojiWeb, :controller

  alias Exmoji.EmojiChar

  @lookup_key "emoji_name"
  def lookup_key, do: @lookup_key

  def show(conn, %{@lookup_key => emoji}) do
    emoji
    |> Exmoji.from_short_name()
    |> render_emoji(conn)
  end

  def show(conn, _) do
    render_emoji(0, conn)
  end

  defp render_emoji(%EmojiChar{} = emoji, conn) do
    json(conn, %{unicode: EmojiChar.render(emoji)})
  end

  defp render_emoji(_, conn) do
    conn
    |> put_status(:not_found)
    |> put_view(EmojiWeb.ErrorView)
    |> render("404.html")
  end

end
