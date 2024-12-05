defmodule AoC.Day05 do
  @moduledoc false

  def part1(filename) do
    {ordering, numbers} = filename |> parse()

    numbers
    |> Enum.filter(fn ns -> Enum.all?(ordering, fn ord -> in_order?(ns, ord) end) end)
    |> Enum.map(&get_middle/1)
    |> Enum.sum()
  end

  def part2(filename) do
    {ordering, numbers} = filename |> parse()

    numbers
    |> Enum.reject(fn ns -> Enum.all?(ordering, fn ord -> in_order?(ns, ord) end) end)
    |> Enum.map(&fix_order(&1, ordering, ordering))
    |> Enum.map(&get_middle/1)
    |> Enum.sum()
  end

  defp get_middle(numbers) do
    Enum.at(numbers, numbers |> length() |> div(2))
  end

  defp fix_order(numbers, [], _orders), do: numbers

  defp fix_order(numbers, [[a, b] = order | rest], orders) do
    case numbers -- numbers -- order do
      [^b, ^a] -> replace(numbers, a, b) |> fix_order(orders, orders)
      _ -> fix_order(numbers, rest, orders)
    end
  end

  defp replace(list, a, b) do
    Enum.map(list, fn
      ^a -> b
      ^b -> a
      c -> c
    end)
  end

  defp in_order?(numbers, order) do
    case numbers -- numbers -- order do
      ^order -> true
      [_, _] -> false
      _ -> true
    end
  end

  defp parse(filename) do
    filename
    |> File.read!()
    |> String.split("\n\n")
    |> then(fn [ordering, numbers] ->
      {
        ordering |> String.split("\n") |> Enum.map(&parse_ordering/1),
        numbers |> String.trim_trailing() |> String.split("\n") |> Enum.map(&String.split(&1, ",")) |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)
      }
    end)
  end

  defp parse_ordering(line) do
    line |> String.split("|") |> Enum.map(&String.to_integer/1)
  end
end
