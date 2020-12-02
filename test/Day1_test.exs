defmodule Day1.Test do
  use ExUnit.Case

  setup do
    input = "1721
979
366
299
675
1456
"

    {:ok, input: input}
  end

  test "succeeds for part1", %{input: input} do
    assert 514_579 = Day1.part1(input)
  end

  test "succeeds for part2", %{input: input} do
    assert 241_861_950 = Day1.part2(input)
  end
end
