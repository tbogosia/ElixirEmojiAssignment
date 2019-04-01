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

  def index(conn, %{"name" => name}) do
    render_emoji_list(conn, Exmoji.find_by_short_name(name))
  end

  def index(conn, %{}) do
    render_emoji_list(conn, Exmoji.all)
  end

  defp json_formatted_emoji(%EmojiChar{} = emoji) do
    %{unicode: EmojiChar.render(emoji)}
  end

  defp render_emoji_list(conn, emoji_list) do
    emoji_list
    |> Enum.map(&(json_formatted_emoji/1))
    |> (&(json(conn, &1))).()
  end

  defp render_emoji(%EmojiChar{} = emoji, conn) do
    json(conn, json_formatted_emoji(emoji))
  end

  defp render_emoji(_, conn) do
    conn
    |> put_status(:not_found)
    |> put_view(EmojiWeb.ErrorView)
    |> render("404.html")
  end

end
