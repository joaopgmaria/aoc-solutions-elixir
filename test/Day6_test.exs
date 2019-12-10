defmodule Day6Test do
  use ExUnit.Case
  doctest Day6

  @tag day: 6
  test "solves #1 example" do
    testdata = "COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L"

    assert 42 == Day6.part1(testdata)
  end

  @tag day: 6
  test "solves #2 example" do
    testdata = "COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN"

    assert 4 == Day6.part2(testdata)
  end

end
