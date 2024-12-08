defmodule AoC.Day08 do
  @moduledoc false

  def part1(filename) do
    {antennas, max_x, max_y} = filename |> parse()

    antennas
    |> Enum.map(&find_antinodes(&1, max_x, max_y))
    |> List.flatten()
    |> MapSet.new()
    |> MapSet.size()
  end

  def part2(filename) do
    {antennas, max_x, max_y} = filename |> parse()

    antennas
    |> Enum.map(&find_all_antinodes(&1, max_x, max_y))
    |> List.flatten()
    |> MapSet.new()
    |> MapSet.size()
  end

  defp find_antinodes({_atype, antennas}, max_x, max_y) do
    for(a1 <- antennas, a2 <- antennas, a1 != a2, do: [a1, a2])
    |> Enum.reduce([], fn [{x1, y1}, {x2, y2}], acc ->
      xd = x2 - x1
      yd = y2 - y1
      x0 = x1 - xd
      y0 = y1 - yd
      x3 = x2 + xd
      y3 = y2 + yd

      acc = if 0 <= x0 && x0 <= max_x && 0 <= y0 && y0 <= max_y, do: [{x0, y0} | acc], else: acc
      acc = if 0 <= x3 && x3 <= max_x && 0 <= y3 && y3 <= max_y, do: [{x3, y3} | acc], else: acc
      acc
    end)
  end

  defp find_all_antinodes({_atype, antennas}, max_x, max_y) do
    for(a1 <- antennas, a2 <- antennas, a1 != a2, do: [a1, a2])
    |> Enum.reduce([], fn [{x1, y1}, {x2, y2}], acc ->
      xd = x2 - x1
      yd = y2 - y1
      acc = get_line({x2, y2}, {-xd, -yd}, acc, max_x, max_y)
      acc = get_line({x1, y1}, {xd, yd}, acc, max_x, max_y)
      acc
    end)
  end

  defp get_line({x1, y1}, {xd, yd}, acc, max_x, max_y) do
    x0 = x1 + xd
    y0 = y1 + yd

    if 0 <= x0 && x0 <= max_x && 0 <= y0 && y0 <= max_y do
      acc = [{x0, y0} | acc]
      get_line({x0, y0}, {xd, yd}, acc, max_x, max_y)
    else
      acc
    end
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.with_index()
    |> Enum.reduce({%{}, 0, 0}, &parse_line/2)
  end

  defp parse_line({line, y}, {acc, max_x, max_y}) do
    line
    |> to_charlist()
    |> Enum.with_index()
    |> Enum.reduce({acc, max_x, max_y}, fn
      {?., x}, {acc, max_x, max_y} ->
        {acc, max(max_x, x), max(max_y, y)}

      {char, x}, {acc, max_x, max_y} ->
        {Map.update(acc, char, [{x, y}], fn positions -> [{x, y} | positions] end), max_x, max_y}
    end)
  end
end
