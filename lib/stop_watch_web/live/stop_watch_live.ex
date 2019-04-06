defmodule StopWatchWeb.StopWatchLive do
  use Phoenix.LiveView

  @state [timer: 0, started: false, laps: [], started_at: nil]

  def mount(_session, socket) do
    {:ok, assign(socket, @state)}
  end

  def render(assigns) do
    StopWatchWeb.PageView.render("index.html", assigns)
  end

  def handle_event("start", _, socket) do
    Process.send_after(self(), :update_timer, 10)
    started_at = System.os_time(:milliseconds) - socket.assigns.timer
    {:noreply, assign(socket, started: true, started_at: started_at)}
  end

  def handle_event("stop", _, socket) do
    {:noreply, assign(socket, started: false)}
  end

  def handle_event("reset", _, socket) do
    {:noreply, assign(socket, timer: 0, started: false, started_at: nil, laps: [])}
  end

  def handle_event("lap", _, socket) do
    lap_num = Enum.count(socket.assigns.laps) + 1
    os_time = System.os_time(:milliseconds)
    time =  os_time - socket.assigns.started_at
    laps = [{lap_num, time}] ++ socket.assigns.laps
    {:noreply, assign(socket, laps: laps, timer: 0, started_at: os_time)}
  end

  def handle_info(:update_timer, socket) do

    if socket.assigns.started do
      Process.send_after(self(), :update_timer, 10)
      timer = System.os_time(:milliseconds) - socket.assigns.started_at
      {:noreply, assign(socket, timer: timer)}
    else
      {:noreply, socket}
    end
  end
end
