defmodule EmojiWeb.EmojiController do
  use EmojiWeb, :controller

  alias Exmoji.EmojiChar

  @lookup_key "emoji_name"
  def lookup_key, do: @lookup_key

  def index(conn, %{"name" => name}) do
    render_emoji_list(Exmoji.find_by_short_name(name), conn)
  end
  def index(conn, _) do
    render_emoji_list(Exmoji.all, conn)
  end

  def show(conn, %{@lookup_key => emoji}) do
    emoji
    |> Exmoji.from_short_name()
    |> render_emoji(conn)
  end

  def show_popular(conn, _) do
    Emoji.PopularityStore.get_most_popular()
    |> Enum.map(&(Exmoji.from_short_name/1))
    |> render_emoji_list(conn)
  end

  defp render_emoji(%EmojiChar{} = emoji, conn) do
    formatted_emoji = json_formatted_emoji(emoji)
    Emoji.PopularityStore.inc_popularity(emoji.short_name)
    json(conn, formatted_emoji)
  end
  defp render_emoji(_, conn) do
    conn
    |> put_status(:not_found)
    |> put_view(EmojiWeb.ErrorView)
    |> render("404.html")
  end

  defp render_emoji_list(emoji_list, conn) do
    emojis = emoji_list |> Enum.map(&(json_formatted_emoji/1))
    json(conn, emojis)
  end

  defp json_formatted_emoji(%EmojiChar{} = emoji) do
    %{unicode: EmojiChar.render(emoji)}
  end

end
