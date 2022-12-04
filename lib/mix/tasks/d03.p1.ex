defmodule Mix.Tasks.D03.P1 do
  use Mix.Task

  import AdventOfCode.Day03

  @shortdoc "Day 03 Part 1"
  def run(args) do
    input = nil
    #   AdventOfCode.Input.get!(3)
    #   |> String.split("\n", trim: true)
    #   |> Enum.map(fn line -> String.split(line, "", trim: true) end)
    #   |> Enum.map(fn line ->
    #     n = length(line) / 2
    #     Enum.split(line, trunc(n))
    #   end)
    # end

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
