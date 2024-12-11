defmodule AoCDay11Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day11.solve("inputs/day11.sample", 6) == 22
    assert AoC.Day11.solve("inputs/day11.sample", 25) == 55312
    assert AoC.Day11.solve("inputs/day11", 25) == 172_484
  end

  test "part2" do
    assert AoC.Day11.solve("inputs/day11", 75) == 205_913_561_055_242
  end
end
