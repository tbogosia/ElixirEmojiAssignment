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

  scope "/emojis", EmojiWeb do
    pipe_through :browser

    get "/popular", EmojiController, :show_popular

    get "/:#{EmojiWeb.EmojiController.lookup_key}", EmojiController, :show

    get "/", EmojiController, :index

  end

end
