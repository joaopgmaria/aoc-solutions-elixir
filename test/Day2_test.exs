defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  @tag day: 2
  test "greets the world" do
    assert Day1.hello() == :world
  end
end
