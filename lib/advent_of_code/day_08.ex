defmodule AdventOfCode.Day08 do
  def part1(args) do
    input =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))

    y_l = length(input)
    x_l = input |> hd() |> length()
    initial_state = %{visibility: %{}, fwd: %{}, rev: %{}}
    forward_coords = for y <- 0..(y_l - 1), x <- 0..(x_l - 1), do: {y, x}
    reverse_coords = for y <- (y_l - 1)..0//-1, x <- (x_l - 1)..0//-1, do: {y, x}

    initial_state
    |> board_state(input, forward_coords, :fwd)
    |> board_state(input, reverse_coords, :rev)
    |> Map.get(:visibility)
    |> Map.values()
    |> Enum.count(fn vis -> vis == true end)
  end

  def part2(_args) do
  end

  defp board_state(initial_state, board, coords, direction) do
    Enum.reduce(
      coords,
      initial_state,
      fn {y, x}, %{visibility: visibility} = state ->
        tallest = Map.get(state, direction)
        cell = Enum.at(board, y) |> Enum.at(x) |> String.to_integer()

        {curr_y, y_tallest} =
          Map.get_and_update(tallest, {:y, y}, fn curr ->
            {curr, max(curr || 0, cell)}
          end)

        {curr_x, both_tallest} =
          Map.get_and_update(y_tallest, {:x, x}, fn curr ->
            {curr, max(curr || 0, cell)}
          end)

        {_curr, new_visibility} =
          Map.get_and_update(visibility, {y, x}, fn curr ->
            visible = curr || calc_visibility(cell, {curr_y, curr_x})
            {curr, visible}
          end)

        state
        |> Map.put(direction, both_tallest)
        |> Map.put(:visibility, new_visibility)
      end
    )
  end

  defp calc_visibility(cell, {y, x}) do
    cond do
      is_nil(y) ->
        true

      is_nil(x) ->
        true

      true ->
        y < cell || x < cell
    end
  end
end
