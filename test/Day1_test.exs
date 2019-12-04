defmodule DTest do
  use ExUnit.Case
  doctest Day1

  @tag day: 1
  test "greets the world" do
    assert Day1.get_fuel(12) == 2
    assert Day1.get_fuel(14) == 2
    assert Day1.get_fuel(1969) == 654
    assert Day1.get_fuel(100756) == 33583
  end
end
