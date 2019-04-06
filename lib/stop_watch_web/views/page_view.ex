defmodule StopWatchWeb.PageView do
  use StopWatchWeb, :view

  def format_timer(timer) do
    min = div(timer, 60000) |> to_string() |> String.pad_leading(2, ["0"])
    seconds = timer |> rem(60000) |> div(1000) |> to_string() |> String.pad_leading(2, ["0"])
    milliseconds = timer |> rem(1000) |> div(10) |> to_string() |> String.pad_leading(2, ["0"])
    "#{min}:#{seconds}:#{milliseconds}"
  end

  def speed_class(val, laps) do
    cond do
      val == fastest_time(laps) -> "fast"
      val == slowest_time(laps) -> "slow"
      true -> "neutral"
    end
  end

  def slowest_time(laps) do
    Enum.reduce(laps, 0, fn {_, x}, acc ->
      case x > acc do
        true -> x
        _ -> acc
      end
    end)
  end

  def fastest_time(laps) do
    Enum.reduce(laps, 999_999_999_999, fn {_, x}, acc ->
      case x < acc do
        true -> x
        _ -> acc
      end
    end)
  end
end
