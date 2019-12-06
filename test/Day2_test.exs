defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  @tag day: 2
  test "executes stop instruction" do
    program = [1,1,1,1,1,1,1,1,1]
    assert {:stop, program} == Day2.execute([99,0,0,0], program)
  end

  @tag day: 2
  test "executes instruction 1" do
    assert {:ok, [2,1,1,1,1,1,1,1,1]} == Day2.execute([1,0,0,0], [1,1,1,1,1,1,1,1,1])
    assert {:ok, [1,1,10,10,20,1,1,1,1]} == Day2.execute([1,2,3,4], [1,1,10,10,1,1,1,1,1])
  end

  @tag day: 2
  test "executes instruction 2" do
    assert {:ok, [1,1,1,1,1,1,1,1,1]} == Day2.execute([2,0,0,0], [1,1,1,1,1,1,1,1,1])
    assert {:ok, [1,1,10,10,100,1,1,1,1]} == Day2.execute([2,2,3,4], [1,1,10,10,1,1,1,1,1])
  end

  @tag day: 2
  test "computes" do
    assert [2,0,0,0,99] == Day2.compute([1,0,0,0,99])
    assert [2,3,0,6,99] == Day2.compute([2,3,0,3,99])
    assert [2,4,4,5,99,9801] == Day2.compute([2,4,4,5,99,0])
    assert [30,1,1,4,2,5,6,0,99] == Day2.compute([1,1,1,4,99,5,6,0,99])
  end

end
