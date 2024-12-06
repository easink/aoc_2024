defmodule AoCDay06Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day06.part1("inputs/day06.sample") == 41
    assert AoC.Day06.part1("inputs/day06") == 5162
  end

  test "part2" do
    assert AoC.Day06.part2("inputs/day06.sample") == 6
    assert AoC.Day06.part2("inputs/day06") == 1909
  end
end
