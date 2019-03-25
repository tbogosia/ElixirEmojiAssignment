defmodule EmojiWeb.EmojiController do
  use EmojiWeb, :controller

  @lookupKey "emoji_name"
  def lookupKey, do: @lookupKey

  def show(conn, %{@lookupKey => "sparkles"}), do: processEmoji("✨", conn)

  def show(conn, %{@lookupKey => "vulcan"}), do: processEmoji("🖖", conn)

  def show(conn, %{@lookupKey => "white_check_mark"}), do: processEmoji("✅", conn)
  def show(conn, %{@lookupKey => "white check mark"}), do: processEmoji("✅", conn)

  def show(conn, %{@lookupKey => "nail_care"}), do: processEmoji("💅", conn)
  def show(conn, %{@lookupKey => "nail care"}), do: processEmoji("💅", conn)

  def show(conn, %{@lookupKey => emoji}) do
    emoji
      |> Exmoji.find_by_short_name
      |> Enum.filter(&(&1.short_name == emoji))
      |> Enum.map(&(Exmoji.EmojiChar.render/1))
      |> showEmojiLookupResult(conn)
  end

  def showEmojiLookupResult([emoji|_], conn), do: processEmoji(emoji, conn)

  def showEmojiLookupResult(_, conn) do
    conn
      |> put_status(:not_found)
      |> put_view(EmojiWeb.ErrorView)
      |> render("404.html")
  end

  defp processEmoji(emoji, conn) do
    jsonValue = %{unicode: emoji}
    json(conn, jsonValue)
  end

end
