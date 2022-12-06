defmodule AdventOfCode.Day06 do
  def part1(args) do
    args
    |> String.split("", trim: true)
    |> find_marker(0, [], 4)
  end

  def part2(args) do
    args
    |> String.split("", trim: true)
    |> find_marker(0, [], 14)
  end

  defp find_marker([], cur_pos, _buffer, _msg_sz), do: cur_pos

  defp find_marker([h | t], cur_pos, buffer, msg_sz) when length(buffer) < msg_sz do
    find_marker(t, cur_pos + 1, buffer ++ [h], msg_sz)
  end

  defp find_marker([h | t], cur_pos, buffer, msg_sz) do
    # adjust window
    buffer =
      buffer
      |> Enum.drop(1)
      |> Enum.concat([h])

    if MapSet.new(buffer) |> MapSet.size() == msg_sz do
      cur_pos + 1
    else
      find_marker(t, cur_pos + 1, buffer, msg_sz)
    end
  end
end
