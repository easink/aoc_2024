defmodule AoCDay12Test do
  use ExUnit.Case

  test "part1" do
    assert AoC.Day12.part1("inputs/day12.sample1") == 4 * 10 + 4 * 8 + 4 * 10 + 1 * 4 + 3 * 8
    assert AoC.Day12.part1("inputs/day12.sample2") == 772
    assert AoC.Day12.part1("inputs/day12.sample3") == 1930
    assert AoC.Day12.part1("inputs/day12") == 1_363_484
  end

  test "part2" do
    assert AoC.Day12.part2("inputs/day12.sample1") == 80
    assert AoC.Day12.part2("inputs/day12.sample2") == 436
    assert AoC.Day12.part2("inputs/day12.sample4") == 236
    assert AoC.Day12.part2("inputs/day12.sample5") == 368
    assert AoC.Day12.part2("inputs/day12.sample3") == 1206
    assert AoC.Day12.part2("inputs/day12") == 838_988
  end
end
