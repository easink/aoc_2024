defmodule AoC.Day02 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> Enum.count(&is_safe/1)
  end

  def part2(filename) do
    filename
    |> parse()
    |> Enum.count(fn report ->
      Enum.any?(0..(length(report) - 1), fn i ->
        List.delete_at(report, i) |> is_safe()
      end)
    end)
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim_trailing()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  defp is_safe([level | report]) do
    diffs = diffs(report, level, [])

    Enum.any?([
      Enum.all?(diffs, &(&1 in 1..3)),
      Enum.all?(diffs, &(&1 in -1..-3//-1))
    ])
  end

  defp diffs([], _prev, acc), do: acc

  defp diffs([level | report], prev, acc),
    do: diffs(report, level, [level - prev | acc])
end
