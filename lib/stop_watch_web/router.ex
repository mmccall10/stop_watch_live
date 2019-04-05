defmodule StopWatchWeb.Router do
  use StopWatchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StopWatchWeb do
    pipe_through :browser

    live "/", StopWatchLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", StopWatchWeb do
  #   pipe_through :api
  # end
end
