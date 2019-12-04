defmodule DTest do
  use ExUnit.Case
  doctest Day1

  @tag day: 1
  test "greets the world" do
    assert Day1.hello() == :world
  end
end
