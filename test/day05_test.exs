defmodule AoCDay05Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day05.part1("inputs/day05.sample") == 143
    assert AoC.Day05.part1("inputs/day05") == 6612
  end

  test "part2" do
    assert AoC.Day05.part2("inputs/day05.sample") == 123
    assert AoC.Day05.part2("inputs/day05") == 4944
  end
end
