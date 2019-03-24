defmodule EmojiWeb.Router do
  use EmojiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EmojiWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/emojis/:emoji_name", EmojiController, :show

  end

  # Other scopes may use custom stacks.
  # scope "/api", EmojiWeb do
  #   pipe_through :api
  # end
end
