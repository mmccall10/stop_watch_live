defmodule StopWatchWeb.PageController do
  use StopWatchWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
