defmodule AoCDay03Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day03.part("inputs/day03.sample") == 161
    assert AoC.Day03.part("inputs/day03") == 182_619_815
  end

  test "part2" do
    # assert AoC.Day03.part("inputs/day03.sample2") == 48
    # assert AoC.Day03.part("inputs/day03") == 80_747_545
  end
end
