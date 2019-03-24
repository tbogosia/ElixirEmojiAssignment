defmodule EmojiWeb.EmojiController do
  use EmojiWeb, :controller

  def show(conn, %{"emoji_name" => "sparkles"}), do: json(conn, "✨")
  def show(conn, %{"emoji_name" => "vulcan"}), do: json(conn, "🖖")
  def show(conn, %{"emoji_name" => "white_check_mark"}), do: json(conn, "✅")
  def show(conn, %{"emoji_name" => "nail_care"}), do: json(conn, "💅")

end
