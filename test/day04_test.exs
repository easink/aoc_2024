defmodule AoCDay04Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day04.part1("inputs/day04.sample") == 18
    assert AoC.Day04.part1("inputs/day04") == 2378
  end

  test "part2" do
    assert AoC.Day04.part2("inputs/day04.sample") == 9
    assert AoC.Day04.part2("inputs/day04") == 1796
  end
end
