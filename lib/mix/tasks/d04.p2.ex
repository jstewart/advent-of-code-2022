defmodule Mix.Tasks.D04.P2 do
  use Mix.Task

  import AdventOfCode.Day04

  @shortdoc "Day 04 Part 2"
  def run(args) do
    input =
      AdventOfCode.Input.get!(4)
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, ",") end)
      |> Enum.map(fn ranges ->
        Enum.map(ranges, fn range ->
          [start, stop] = String.split(range, "-")
          [String.to_integer(start), String.to_integer(stop)]
        end)
      end)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
