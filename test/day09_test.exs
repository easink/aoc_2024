defmodule AoCDay09Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day09.part1("inputs/day09.sample") == 1928
    assert AoC.Day09.part1("inputs/day09") == 6_390_180_901_651
  end

  test "part2" do
    assert AoC.Day09.part2("inputs/day09.sample") == 2858
    assert AoC.Day09.part2("inputs/day09") == 6_412_390_114_238
  end
end
