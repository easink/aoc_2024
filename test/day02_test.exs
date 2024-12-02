defmodule AoCDay02Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day02.part1("inputs/day02.sample") == 2
    assert AoC.Day02.part1("inputs/day02") == 220
  end

  test "part2" do
    assert AoC.Day02.part2("inputs/day02.sample") == 4
    assert AoC.Day02.part2("inputs/day02") == 296
  end
end
