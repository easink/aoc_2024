defmodule AoC.Day11 do
  @moduledoc false

  def solve(filename, times) do
    stones = filename |> parse_line()

    1..times
    |> Enum.reduce(stones, fn _n, acc -> blink(acc) end)
    |> Map.values()
    |> Enum.sum()
  end

  defp update(acc, key, n), do: Map.update(acc, key, n, fn x -> x + n end)

  defp blink(stones) do
    Enum.reduce(stones, %{}, fn {stone, n}, acc ->
      digits = Integer.digits(stone)
      len = length(digits)

      cond do
        stone == 0 ->
          update(acc, 1, n)

        rem(len, 2) == 0 ->
          {a, b} = Enum.split(digits, div(len, 2))

          acc
          |> update(Integer.undigits(a), n)
          |> update(Integer.undigits(b), n)

        true ->
          update(acc, stone * 2024, n)
      end
    end)
  end

  defp parse_line(filename) do
    filename
    |> File.read!()
    |> String.trim_trailing()
    |> String.split(" ")
    |> Enum.map(&{String.to_integer(&1), 1})
    |> Map.new()
  end
end
