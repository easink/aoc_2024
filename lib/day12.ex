defmodule AoC.Day12 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> parse_regions()
    |> calc_sides()
  end

  def part2(filename) do
    map = filename |> parse()
    regions = map |> parse_regions()

    Enum.reduce(regions, 0, fn region, acc ->
      by_x = Enum.sort_by(region, fn {x, y} -> {x, y} end) |> Enum.chunk_by(fn {x, _y} -> x end)
      by_y = Enum.sort_by(region, fn {x, y} -> {y, x} end) |> Enum.chunk_by(fn {_x, y} -> y end)

      top = Enum.map(by_y, &fences_in_dir(&1, region, {0, -1}, {-1, 0})) |> Enum.sum()
      bottom = Enum.map(by_y, &fences_in_dir(&1, region, {0, 1}, {-1, 0})) |> Enum.sum()
      left = Enum.map(by_x, &fences_in_dir(&1, region, {-1, 0}, {0, -1})) |> Enum.sum()
      right = Enum.map(by_x, &fences_in_dir(&1, region, {1, 0}, {0, -1})) |> Enum.sum()

      area = MapSet.size(region)

      acc + (top + bottom + left + right) * area
    end)
  end

  defp fences_in_dir(positions, region, in_dir, prev_pos_dir) do
    positions
    |> Enum.reject(fn pos ->
      up = pos_add(pos, in_dir)
      MapSet.member?(region, up)
    end)
    |> chunk_by_consecutive(prev_pos_dir)
    |> Enum.count()
  end

  def chunk_by_consecutive(enum, prevdir) do
    chunk_fun = fn pos, acc ->
      prev = pos_add(pos, prevdir)

      case acc do
        [] -> {:cont, [pos]}
        [^prev | _acc] -> {:cont, [pos | acc]}
        _acc -> {:cont, Enum.reverse(acc), [pos]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    Enum.chunk_while(enum, [], chunk_fun, after_fun)
  end

  defp calc_sides(regions) do
    regions
    |> fences()
    |> Enum.map(fn region ->
      area = length(region)

      region
      |> Enum.map(fn pos -> Enum.count(pos) end)
      |> Enum.sum()
      |> Kernel.*(area)
    end)
    |> Enum.sum()
  end

  defp fences(regions) do
    Enum.map(regions, fn region ->
      Enum.map(region, fn pos ->
        [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
        |> Enum.map(fn dir -> pos_add(pos, dir) end)
        |> Enum.reject(fn neighbour -> MapSet.member?(region, neighbour) end)
      end)
    end)
  end

  defp parse_regions(map, regions \\ [])

  defp parse_regions(map, regions) when map_size(map) == 0, do: regions

  defp parse_regions(map, regions) do
    pos = Enum.at(map, 0) |> elem(0)
    {map, region} = parse_region({map, MapSet.new()}, pos, map[pos])
    parse_regions(map, [region | regions])
  end

  defp parse_region({map, region}, pos, current) do
    if map[pos] == current do
      map = Map.delete(map, pos)
      region = MapSet.put(region, pos)

      [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
      |> Enum.map(fn dir -> pos_add(pos, dir) end)
      |> Enum.reduce({map, region}, fn next, {map_acc, region_acc} ->
        parse_region({map_acc, region_acc}, next, current)
      end)
    else
      {map, region}
    end
  end

  defp pos_add({x, y}, {xd, yd}), do: {x + xd, y + yd}

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
    |> Enum.reduce(acc, fn {char, x}, acc -> Map.put(acc, {x, y}, char) end)
  end
end
