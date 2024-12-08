defmodule AoCDay08Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day08.part1("inputs/day08.sample") == 14
    assert AoC.Day08.part1("inputs/day08") == 308
  end

  test "part2" do
    assert AoC.Day08.part2("inputs/day08.sample") == 34
    assert AoC.Day08.part2("inputs/day08") == 1147
  end
end
