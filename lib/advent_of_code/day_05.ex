defmodule AdventOfCode.Day05 do
  def part1(args) do
    {state, moves} = parse_input(args)

    Enum.reduce(moves, state, fn instruction, acc -> move(instruction, acc) end)
    |> Enum.reduce("", fn {_k, [h | _]}, acc -> acc <> h end)
  end

  def part2(args) do
    {state, moves} = parse_input(args)

    Enum.reduce(moves, state, fn instruction, acc ->
      move(instruction, acc, ordering: :natural)
    end)
    |> Enum.reduce("", fn {_k, [h | _]}, acc -> acc <> h end)
  end

  defp move([n, src, dest], state, options \\ []) do
    ordering = Keyword.get(options, :ordering, :stack)
    n = String.to_integer(n)

    {src_crates, state} =
      Map.get_and_update!(state, src, fn x ->
        {x, Enum.drop(x, n)}
      end)

    {_dst_crates, state} =
      Map.get_and_update!(state, dest, fn x ->
        crates = src_crates |> Enum.take(n)

        to_add =
          case ordering do
            :stack -> Enum.reverse(crates)
            _ -> crates
          end

        {x, Enum.concat(to_add, x)}
      end)

    state
  end

  @type state :: %{String.t() => list()}
  @type moves :: list(String.t())

  @spec parse_input(String.t()) :: {state, moves}
  def parse_input(input) do
    [state, moves] =
      input
      |> String.split("\n\n")

    {parse_state(state), parse_moves(moves)}
  end

  defp parse_moves(moves) do
    regex = ~r/move (?<n>\d+) from (?<src>\d+) to (?<dst>\d+)/

    moves
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      %{"n" => n, "src" => src, "dst" => dst} = Regex.named_captures(regex, line)
      [n, src, dst]
    end)
  end

  defp parse_state(state) do
    state
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("")
      |> Enum.drop(2)
      |> Enum.drop(-1)
      |> Enum.take_every(4)
    end)
    # AKA - transpose
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.reduce(%{}, fn stack, acc ->
      [stack_id] = Enum.take(stack, -1)

      stack_contents =
        Enum.drop(stack, -1)
        |> Enum.filter(&(&1 != " "))

      Map.put(acc, stack_id, stack_contents)
    end)
  end
end
