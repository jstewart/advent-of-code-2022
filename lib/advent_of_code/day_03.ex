defmodule AdventOfCode.Day03 do
  @moduledoc """
  Intuition:

  Part 1: Split each line in half
  convert each char of split line into set, find the intersection
  calculate the priority of the intersection and sum

  Part 2: Chunk input into groups of 3 lines
  convert each char of each chunk into set, find the intersection
  between both chunks as sets
  calculate the priority of the intersection and sum
  """
  def part1(args) do
    args
    |> Enum.map(fn {l1, l2} -> track_dupes(l1, l2) end)
    |> Enum.map(&tally_priorities/1)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> Enum.map(fn [l1, l2, l3] -> track_dupes(l1, l2, l3) end)
    |> Enum.map(&tally_priorities/1)
    |> Enum.sum()
  end

  defp track_dupes(list1, list2) do
    MapSet.intersection(
      MapSet.new(list1),
      MapSet.new(list2)
    )
  end

  defp track_dupes(list1, list2, list3) do
    MapSet.intersection(
      track_dupes(list1, list2),
      MapSet.new(list3)
    )
  end

  defp calculate_priority(item) do
    charcode = String.to_charlist(item) |> hd
    if charcode > 96 and charcode < 123, do: charcode - 96, else: charcode - 38
  end

  defp tally_priorities(set) do
    set
    |> Enum.map(&calculate_priority/1)
    |> Enum.sum()
  end
end
