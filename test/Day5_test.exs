defmodule Day5Test do
  use ExUnit.Case
  doctest Day5

  @tag day: 5
  test "gets parameter on immediate mode" do
    assert 2 == Day5.get_param([10,20,30],2,1)
    assert 0 == Day5.get_param([10,20,30],0,1)
  end

  @tag day: 5
  test "gets parameter on position mode" do
    assert 30 == Day5.get_param([10,20,30],2,0)
    assert 10 == Day5.get_param([10,20,30],0,0)
  end

  @tag day: 5
  test "parses opcodes" do
    assert {0,0,0,1} == Day5.parse_modes(1)
    assert {0,0,0,2} == Day5.parse_modes(2)
    assert {0,0,0,1} == Day5.parse_modes(01)
    assert {0,0,0,2} == Day5.parse_modes(02)
    assert {0,1,0,2} == Day5.parse_modes(1002)
    assert {1,1,0,2} == Day5.parse_modes(11002)
    assert {0,0,1,4} == Day5.parse_modes(104)
    assert {0,1,0,5} == Day5.parse_modes(1005)
  end

  @tag day: 5
  test "executes instruction #99" do
    program = [0,0,0,0]
    ip = 0

    assert {:stop, program, ip} == Day5.execute_instruction(99, [1,2,3],{4,5,6},program, ip)
  end

  @tag day: 5
  test "executes instruction #1" do
    program = [1,11,22,0]
    ip = 11

    assert {:ok, [33,11,22,0], 15} == Day5.execute_instruction(1, [1,2,0],{0,0,6},program, ip)
    assert {:ok, [13,11,22,0], 15} == Day5.execute_instruction(1, [1,2,0],{0,1,6},program, ip)
    assert {:ok, [23,11,22,0], 15} == Day5.execute_instruction(1, [1,2,0],{1,0,6},program, ip)
    assert {:ok, [3,11,22,0], 15} == Day5.execute_instruction(1, [1,2,0],{1,1,6},program, ip)
  end

  @tag day: 5
  test "executes instruction #2" do
    program = [1,11,22,0]
    ip = 11

    assert {:ok, [242,11,22,0], 15} == Day5.execute_instruction(2, [1,2,0],{0,0,6},program, ip)
    assert {:ok, [22,11,22,0], 15} == Day5.execute_instruction(2, [1,2,0],{0,1,6},program, ip)
    assert {:ok, [22,11,22,0], 15} == Day5.execute_instruction(2, [1,2,0],{1,0,6},program, ip)
    assert {:ok, [2,11,22,0], 15} == Day5.execute_instruction(2, [1,2,0],{1,1,6},program, ip)
  end

  @tag day: 5
  test "executes instruction #3" do
    #?
  end

  @tag day: 5
  test "executes instruction #4" do
    #?
  end

  @tag day: 5
  test "executes instruction #5" do
    ip = 11

    assert {:ok, [5,0,30], 14} == Day5.execute_instruction(5, [1,2],{0,0,6},[5,0,30], ip)
    assert {:ok, [5,1,40], 40} == Day5.execute_instruction(5, [1,2],{0,0,6},[5,1,40], ip)

    assert {:ok, [5,0,50], 14} == Day5.execute_instruction(5, [0,2],{1,0,6},[5,0,50], ip)
    assert {:ok, [5,1,60], 60} == Day5.execute_instruction(5, [1,2],{1,0,6},[5,1,60], ip)

    assert {:ok, [5,0,70], 14} == Day5.execute_instruction(5, [1,2],{0,1,6},[5,0,70], ip)
    assert {:ok, [5,1,80], 2} == Day5.execute_instruction(5, [1,2],{0,1,6},[5,1,80], ip)

    assert {:ok, [5,0,90], 14} == Day5.execute_instruction(5, [0,2],{1,1,6},[5,0,90], ip)
    assert {:ok, [5,1,100], 2} == Day5.execute_instruction(5, [1,2],{1,1,6},[5,1,100], ip)
  end

  @tag day: 5
  test "executes instruction #6" do
    ip = 11

    assert {:ok, [6,0,30], 30} == Day5.execute_instruction(6, [1,2],{0,0,6},[6,0,30], ip)
    assert {:ok, [6,1,40], 14} == Day5.execute_instruction(6, [1,2],{0,0,6},[6,1,40], ip)

    assert {:ok, [6,0,50], 50} == Day5.execute_instruction(6, [0,2],{1,0,6},[6,0,50], ip)
    assert {:ok, [6,1,60], 14} == Day5.execute_instruction(6, [1,2],{1,0,6},[6,1,60], ip)

    assert {:ok, [6,0,70], 2} == Day5.execute_instruction(6, [1,2],{0,1,6},[6,0,70], ip)
    assert {:ok, [6,1,80], 14} == Day5.execute_instruction(6, [1,2],{0,1,6},[6,1,80], ip)

    assert {:ok, [6,1,90], 2} == Day5.execute_instruction(6, [0,2],{1,1,6},[6,1,90], ip)
    assert {:ok, [6,0,100], 14} == Day5.execute_instruction(6, [1,2],{1,1,6},[6,0,100], ip)
  end

  @tag day: 5
  test "executes instruction #7" do
    ip = 11

    assert {:ok, [7,0,1,1], 15} == Day5.execute_instruction(7, [1,2,3],{0,0,6},[7,0,1,3], ip)
    assert {:ok, [7,2,1,0], 15} == Day5.execute_instruction(7, [1,2,3],{0,0,6},[7,2,1,3], ip)

    assert {:ok, [7,0,1,1], 15} == Day5.execute_instruction(7, [0,2,3],{1,0,6},[7,0,1,3], ip)
    assert {:ok, [7,0,1,0], 15} == Day5.execute_instruction(7, [1,2,3],{1,0,6},[7,0,1,3], ip)

    assert {:ok, [7,0,1,1], 15} == Day5.execute_instruction(7, [1,2,3],{0,1,6},[7,0,1,3], ip)
    assert {:ok, [7,2,1,0], 15} == Day5.execute_instruction(7, [1,2,3],{0,1,6},[7,2,1,3], ip)

    assert {:ok, [7,0,1,1], 15} == Day5.execute_instruction(7, [1,2,3],{1,1,6},[7,0,1,3], ip)
    assert {:ok, [7,0,1,0], 15} == Day5.execute_instruction(7, [2,2,3],{1,1,6},[7,0,1,3], ip)
  end

  @tag day: 5
  test "executes instruction #8" do
    ip = 11

    assert {:ok, [8,0,0,1], 15} == Day5.execute_instruction(8, [1,2,3],{0,0,6},[8,0,0,3], ip)
    assert {:ok, [8,0,1,0], 15} == Day5.execute_instruction(8, [1,2,3],{0,0,6},[8,0,1,3], ip)

    assert {:ok, [8,0,1,1], 15} == Day5.execute_instruction(8, [1,2,3],{1,0,6},[8,0,1,3], ip)
    assert {:ok, [8,0,1,0], 15} == Day5.execute_instruction(8, [0,2,3],{1,0,6},[8,0,1,3], ip)

    assert {:ok, [8,0,1,1], 15} == Day5.execute_instruction(8, [1,0,3],{0,1,6},[8,0,1,3], ip)
    assert {:ok, [8,0,1,0], 15} == Day5.execute_instruction(8, [1,2,3],{0,1,6},[8,0,1,3], ip)

    assert {:ok, [8,0,1,1], 15} == Day5.execute_instruction(8, [2,2,3],{1,1,6},[8,0,1,3], ip)
    assert {:ok, [8,0,1,0], 15} == Day5.execute_instruction(8, [1,2,3],{1,1,6},[8,0,1,3], ip)
  end

end
