defmodule StopWatchWeb.StopWatchLive do
  use Phoenix.LiveView

  @state [timer: 0, started: false, laps: []]

  def mount(_session, socket) do
    {:ok, assign(socket, @state)}
  end

  def render(assigns) do
    StopWatchWeb.PageView.render("index.html", assigns)
  end

  def handle_event("start", _, socket) do
    Process.send_after(self(), :update_time, 10)

    {:noreply, assign(socket, started: true)}
  end

  def handle_event("stop", _, socket) do
    {:noreply, assign(socket, started: false)}
  end

  def handle_info(:update_time, socket) do
    case socket.assigns.started do
      true ->
        Process.send_after(self(), :update_time, 10)
        timer = socket.assigns.timer + 10
        {:noreply, assign(socket, timer: timer)}

      _ ->
        {:noreply, socket}
    end
  end
end
