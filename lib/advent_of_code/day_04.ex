defmodule AdventOfCode.Day04 do
  def part1(args) do
    args
    |> Enum.filter(&range_contains_other?/1)
    |> length()
  end

  def part2(args) do
    args
    |> Enum.filter(&range_overlaps?/1)
    |> length()
  end

  defp range_contains_other?([[r1start, r1stop], [r2start, r2stop]]) do
    cond do
      r1start >= r2start && r1stop <= r2stop -> true
      r2start >= r1start && r2stop <= r1stop -> true
      true -> false
    end
  end

  defp range_overlaps?([[r1start, r1stop], [r2start, r2stop]]) do
    not Range.disjoint?(
      r1start..r1stop,
      r2start..r2stop
    )
  end
end
