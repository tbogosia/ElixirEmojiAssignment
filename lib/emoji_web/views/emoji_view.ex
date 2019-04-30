defmodule EmojiWeb.EmojiView do
  use EmojiWeb, :view

  alias Exmoji.EmojiChar

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  def json_formatted_emoji(%EmojiChar{} = emoji) do
    %{unicode: EmojiChar.render(emoji)}
  end

end
