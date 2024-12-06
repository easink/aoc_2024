defmodule AoC.Day06 do
  @moduledoc false

  def part1(filename) do
    {map, start} = filename |> parse()

    traverse(start, {0, -1}, map)
    |> MapSet.size()
  end

  def part2(filename) do
    {map, start} = filename |> parse()

    traverse(start, {0, -1}, map)
    |> MapSet.delete(start)
    |> Enum.filter(fn pos ->
      map = Map.put(map, pos, ?#)
      traverse(start, {0, -1}, map) == :loop
    end)
    |> length()
  end

  defp traverse(pos, dir, map, set \\ MapSet.new()) do
    next_set = MapSet.put(set, {pos, dir})
    next_pos = walk(pos, dir)
    next_char = map[next_pos]

    cond do
      MapSet.member?(set, {pos, dir}) ->
        :loop

      next_char == ?# ->
        new_dir = turn_right(dir)
        traverse(pos, new_dir, map, next_set)

      next_char == ?. ->
        walk(pos, dir)
        |> traverse(dir, map, next_set)

      next_char == nil ->
        next_set
        |> MapSet.to_list()
        |> Enum.map(fn {pos, _dir} -> pos end)
        |> MapSet.new()
    end
  end

  defp walk({pos_x, pos_y}, {dir_x, dir_y}), do: {pos_x + dir_x, pos_y + dir_y}
  defp turn_right({1, 0}), do: {0, 1}
  defp turn_right({0, 1}), do: {-1, 0}
  defp turn_right({-1, 0}), do: {0, -1}
  defp turn_right({0, -1}), do: {1, 0}

  defp parse(filename) do
    map =
      filename
      |> File.stream!()
      |> Enum.map(&String.trim_trailing/1)
      |> Enum.with_index()
      |> Enum.reduce(%{}, &parse_line/2)

    {start, _} = Enum.find(map, fn {_k, v} -> v == ?^ end)
    map = Map.put(map, start, ?.)
    {map, start}
  end

  defp parse_line({line, y}, acc) do
    line
    |> to_charlist()
    |> Enum.with_index()
    |> Enum.reduce(acc, fn {char, x}, acc -> Map.put(acc, {x, y}, char) end)
  end
end
