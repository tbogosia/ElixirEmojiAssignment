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

  def show(conn, %{"name" => name}) do
    formatted_emoji =
    Exmoji.find_by_short_name(name)
    |> Enum.map(&(json_formatted_emoji/1))
    json(conn, formatted_emoji)
  end

  def show(conn, %{}) do
    formatted_emoji =
    Exmoji.all
    |> Enum.map(&(json_formatted_emoji/1))
    json(conn, formatted_emoji)
  end

  defp json_formatted_emoji(%EmojiChar{} = emoji) do
    %{unicode: EmojiChar.render(emoji)}
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
