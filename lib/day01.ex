defmodule AoC.Day01 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip_with(fn [a, b] -> abs(a - b) end)
    |> Enum.sum()
  end

  def part2(filename) do
    {left, freq} =
      filename
      |> parse()
      |> then(fn [left, right] -> {left, Enum.frequencies(right)} end)

    left
    |> Enum.map(&(&1 * Map.get(freq, &1, 0)))
    |> Enum.sum()
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&parse_line/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp parse_line(line) do
    line
    |> String.trim_trailing()
    |> String.split(" ")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.to_integer/1)
  end
end
