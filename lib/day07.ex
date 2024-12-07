defmodule AoC.Day07 do
  @moduledoc false

  def part1(filename) do
    funs = [&Kernel.+/2, &Kernel.*/2]

    filename
    |> parse()
    |> Enum.filter(&is_solvable(&1, funs))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  def part2(filename) do
    funs = [&Kernel.+/2, &Kernel.*/2, &merge/2]

    filename
    |> parse()
    |> Enum.filter(&is_solvable(&1, funs))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  defp is_solvable([int | ints], funs, sum, acc),
    do: Enum.any?(funs, &is_solvable(ints, funs, sum, &1.(acc, int)))

  defp is_solvable([], _funs, sum, acc), do: sum == acc
  defp is_solvable({sum, [int | ints]}, funs), do: is_solvable(ints, funs, sum, int)

  def merge(a, b), do: merge(a, b, b)
  def merge(a, b, 0), do: a + b
  def merge(a, b, c), do: merge(a * 10, b, div(c, 10))

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [sum, ints] =
      line
      |> String.trim_trailing()
      |> String.split(": ")

    sum = String.to_integer(sum)
    ints = ints |> String.split(" ") |> Enum.map(&String.to_integer/1)
    {sum, ints}
  end
end
