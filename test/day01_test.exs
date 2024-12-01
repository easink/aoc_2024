defmodule AoCDay01Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day01.part1("inputs/day01.sample") == 11
    assert AoC.Day01.part1("inputs/day01") == 1_666_427
  end

  test "part2" do
    assert AoC.Day01.part2("inputs/day01.sample") == 31
    assert AoC.Day01.part2("inputs/day01") == 24_316_233
  end
end
