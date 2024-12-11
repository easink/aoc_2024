defmodule AoC.Day10 do
  @moduledoc false

  def part1(filename) do
    topography = filename |> parse()

    start_positions = Map.filter(topography, fn {_coord, value} -> value == 0 end) |> Map.keys()

    Enum.map(start_positions, fn pos -> find_peeks(topography, pos) end)
    |> Enum.map(&List.flatten/1)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def part2(filename) do
    topography = filename |> parse()

    start_positions = Map.filter(topography, fn {_coord, value} -> value == 0 end) |> Map.keys()

    Enum.map(start_positions, fn pos -> find_peeks(topography, pos) end)
    |> Enum.map(&List.flatten/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp find_peeks(topography, {x, y} = pos) do
    height = topography[pos]

    if height == 9 do
      pos
    else
      [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
      |> Enum.map(fn {xd, yd} -> {x + xd, y + yd} end)
      |> Enum.filter(fn pos -> topography[pos] == height + 1 end)
      |> Enum.map(fn next -> find_peeks(topography, next) end)
    end
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, &parse_line/2)
  end

  defp parse_line({line, y}, acc) do
    line
    |> to_charlist()
    |> Enum.with_index()
    |> Enum.reduce(acc, fn {char, x}, acc -> Map.put(acc, {x, y}, char - ?0) end)
  end
end
