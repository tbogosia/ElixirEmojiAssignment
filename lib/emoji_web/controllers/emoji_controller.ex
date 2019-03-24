defmodule EmojiWeb.EmojiController do
  use EmojiWeb, :controller

  @lookupKey "emoji_name"
  def lookupKey, do: @lookupKey

  def show(conn, %{@lookupKey => ":sparkles:"}), do: processEmoji(conn, "✨")

  def show(conn, %{@lookupKey => ":vulcan:"}), do: processEmoji(conn, "🖖")

  def show(conn, %{@lookupKey => ":white_check_mark:"}), do: processEmoji(conn, "✅")

  def show(conn, %{@lookupKey => ":nail_care:"}), do: processEmoji(conn, "💅")

  def show(conn, _params), do: json(conn, "Woah, I don't know what to do with that...")

  defp processEmoji(conn, emoji) do
    emoji
      |> generateEmojiJSON
      |> finalizeResponse(conn)
  end

  defp generateEmojiJSON(emoji), do: %{ unicode: emoji }

  defp finalizeResponse(res, conn), do: json(conn, res)

end
