defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  @tag day: 3
  test "gets taxicab distance from center" do
    center = {0, 0}
    first = {1, 0}
    second = {-3, 0}
    third = {-3, 20}
    forth = {0, 20}

    assert 0 == Day3.get_taxicab_distance(center)
    assert 1 == Day3.get_taxicab_distance(first)
    assert 3 == Day3.get_taxicab_distance(second)
    assert 23 == Day3.get_taxicab_distance(third)
    assert 20 == Day3.get_taxicab_distance(forth)
  end

  @tag day: 3
  test "gets taxicab distance commutative" do
    first = {1, 0}
    second = {-3, 0}

    assert Day3.get_taxicab_distance(second, first) == Day3.get_taxicab_distance(first, second)
  end

  @tag day: 3
  test "gets path no moves" do
    assert [] == Day3.get_path([])
  end

  @tag day: 3
  test "gets path single move, one step" do
    assert [{0,1}] == Day3.get_path(["U1"])
    assert [{0,-1}] == Day3.get_path(["D1"])
    assert [{-1,0}] == Day3.get_path(["L1"])
    assert [{1,0}] == Day3.get_path(["R1"])
  end

  @tag day: 3
  test "gets path single move, multiple steps" do
    assert [{1,0}, {2,0}] == Day3.get_path(["R2"])
    assert [{0,-1},{0,-2},{0,-3}] == Day3.get_path(["D3"])
  end

  @tag day: 3
  test "gets path multiple moves, multiple steps" do
    assert [{1,0}, {2,0}, {2,-1}, {2, -2}] == Day3.get_path(["R2","D2"])
  end

  @tag day: 3
  test "gets shortest manhattan distance" do
    assert 6 == Day3.get_smallest_intersection_distance("R8,U5,L5,D3\nU7,R6,D4,L4")
    assert 159 == Day3.get_smallest_intersection_distance("R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83")
    assert 135 == Day3.get_smallest_intersection_distance("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
  end

  @tag day: 3
  test "gets shortest distance by step count" do
    assert 30 == Day3.get_smallest_intersection_steps("R8,U5,L5,D3\nU7,R6,D4,L4")
    assert 610 == Day3.get_smallest_intersection_steps("R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83")
    assert 410 == Day3.get_smallest_intersection_steps("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
  end

end
