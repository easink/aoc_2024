defmodule AoCDay07Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day07.part1("inputs/day07.sample") == 3749
    assert AoC.Day07.part1("inputs/day07") == 5_540_634_308_362
  end

  test "part2" do
    assert AoC.Day07.part2("inputs/day07.sample") == 11387
    assert AoC.Day07.part2("inputs/day07") == 472_290_821_152_397
  end
end
