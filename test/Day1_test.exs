defmodule DTest do
  use ExUnit.Case
  doctest Day1

  @tag day: 1
  test "gets fuel" do
    assert Day1.get_fuel(12) == 2
    assert Day1.get_fuel(14) == 2
    assert Day1.get_fuel(1969) == 654
    assert Day1.get_fuel(100756) == 33583
  end

  @tag day: 1
  test "gets (good) fuel" do
    assert Day1.get_fuel_corrected(14) == 2
    assert Day1.get_fuel_corrected(1969) == 966
    assert Day1.get_fuel_corrected(100756) == 50346
  end
end
