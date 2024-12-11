defmodule AoCDay10Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day10.part1("inputs/day10.sample1") == 1
    assert AoC.Day10.part1("inputs/day10.sample2") == 2
    assert AoC.Day10.part1("inputs/day10.sample3") == 36
    assert AoC.Day10.part1("inputs/day10") == 717
  end

  test "part2" do
    assert AoC.Day10.part2("inputs/day10.sample4") == 3
    assert AoC.Day10.part2("inputs/day10.sample5") == 13
    assert AoC.Day10.part2("inputs/day10.sample6") == 81
    assert AoC.Day10.part2("inputs/day10") == 6_412_390_114_238
  end
end
