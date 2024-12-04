defmodule AoC.Day04 do
  @moduledoc false

  def part1(filename) do
    {map, max_x, max_y} = filename |> parse()

    horizontal = for(y <- 0..max_y, do: for(x <- 0..max_x, do: map[{x, y}]))
    vertical = for(x <- 0..max_x, do: for(y <- 0..max_y, do: map[{x, y}]))
    diagonal_nw = for(x <- 0..max_x, do: {x, 0}) ++ for(y <- 1..max_y, do: {0, y})
    diagonal1 = for start_coord <- diagonal_nw, do: diagonal(map, start_coord, {1, 1})
    diagonal_sw = for(x <- 0..max_x, do: {x, max_y}) ++ for(y <- 0..(max_y - 1), do: {0, y})
    diagonal2 = for start_coord <- diagonal_sw, do: diagonal(map, start_coord, {1, -1})

    [
      horizontal,
      Enum.map(horizontal, &Enum.reverse/1),
      vertical,
      Enum.map(vertical, &Enum.reverse/1),
      diagonal1,
      Enum.map(diagonal1, &Enum.reverse/1),
      diagonal2,
      Enum.map(diagonal2, &Enum.reverse/1)
    ]
    |> sum(fn dir -> sum(dir, &count_xmax/1) end)
  end

  def part2(filename) do
    {map, max_x, max_y} = filename |> parse()

    diagonal_nw = for(x <- 0..max_x, do: {x, 0}) ++ for(y <- 1..max_y, do: {0, y})
    diagonal = for start_coord <- diagonal_nw, do: diagonal_x(map, start_coord)

    [
      diagonal,
      Enum.map(diagonal, &Enum.reverse/1)
    ]
    |> sum(fn dir -> sum(dir, &count_x_max/1) end)
  end

  defp diagonal(map, {x, y}, {dx, dy} = dir, acc \\ []) do
    case map[{x, y}] do
      nil -> acc
      char -> diagonal(map, {x + dx, y + dy}, dir, [char | acc])
    end
  end

  defp diagonal_x(map, {x, y}, acc \\ []) do
    case map[{x, y}] do
      nil ->
        acc

      char ->
        sw = map[{x - 1, y + 1}]
        ne = map[{x + 1, y - 1}]

        diagonal_x(map, {x + 1, y + 1}, [{char, sw, ne} | acc])
    end
  end

  defp count_xmax([?X, ?M, ?A, ?S | rest]), do: 1 + count_xmax(rest)
  defp count_xmax([_ | rest]), do: count_xmax(rest)
  defp count_xmax([]), do: 0

  defp count_x_max([{?M, _, _}, {?A, ?M, ?S}, {?S, _, _} | rest]), do: 1 + count_x_max(rest)
  defp count_x_max([{?M, _, _}, {?A, ?S, ?M}, {?S, _, _} | rest]), do: 1 + count_x_max(rest)
  defp count_x_max([_ | rest]), do: count_x_max(rest)
  defp count_x_max([]), do: 0

  defp sum(enum, fun), do: Enum.reduce(enum, 0, fn x, acc -> fun.(x) + acc end)

  defp parse(filename) do
    lines =
      filename
      |> File.stream!()
      |> Enum.map(&String.trim_trailing/1)

    max_y = length(lines) - 1
    max_x = String.length(hd(lines)) - 1

    map =
      lines
      |> Enum.with_index()
      |> Enum.reduce(%{}, &parse_line/2)

    {map, max_x, max_y}
  end

  defp parse_line({line, y}, acc) do
    line
    |> to_charlist()
    |> Enum.with_index()
    |> Enum.reduce(acc, fn {char, x}, acc -> Map.put(acc, {x, y}, char) end)
  end
end
