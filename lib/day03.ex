defmodule AoC.Day03 do
  @moduledoc """
  Too naive solution, no time today...
  Comment out do() and don't() for part2
  """

  def part(filename) do
    filename
    |> File.read!()
    |> mul()
    |> Enum.sum()
  end

  def mul(line, acc \\ [], state \\ :enabled)

  def mul("", acc, _state), do: acc
  # def mul("do()" <> rest, acc, _state), do: mul(rest, acc, :enabled)
  # def mul("don't()" <> rest, acc, _state), do: mul(rest, acc, :disabled)

  def mul(line, acc, :enabled = state) do
    <<_char, rest::binary>> = line

    Regex.named_captures(~r/^mul\((?<first>[0-9]{1,3}),(?<second>[0-9]{1,3})\)/, line)
    |> case do
      nil ->
        mul(rest, acc, state)

      %{"first" => first, "second" => second} ->
        first = String.to_integer(first)
        second = String.to_integer(second)
        mul(rest, [first * second | acc], state)
    end
  end

  def mul(<<_char, rest::binary>>, acc, state) do
    mul(rest, acc, state)
  end
end
