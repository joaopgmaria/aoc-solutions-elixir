defmodule Day3 do
  @input "priv/inputs/day3.txt"
  def get_input(), do: File.read!(@input)

  def part1() do
    get_input()
      |> get_smallest_intersection_distance()
  end

  def part2() do
    get_input()
      |> get_smallest_intersection_steps()
  end

  def get_smallest_intersection_distance(input) do
    input
      |> get_wires_paths()
      |> get_intersections()
      |> Enum.map(&get_taxicab_distance/1)
      |> Enum.sort()
      |> hd()
  end

  def get_smallest_intersection_steps(input) do
    paths = input |> get_wires_paths()
    intersections = paths |> get_intersections()

    count_steps_to_intersections(paths, intersections)
      |> Enum.sort()
      |> hd()
  end

  def get_intersections([red, green]) do
    lst = red -- green
    red -- lst
  end

  def get_wires_paths(input) do
    input
      |> String.replace("\r", "", trim: true)
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1,","))
      |> Enum.map(&get_path/1)
  end

  def get_path(_, segments \\ [{0, 0}])

  def get_path([], segments) do
    #Reverse order and remove center reference
    [_center|path] = Enum.reverse(segments)

    path
  end

  def get_path([<<dir::binary()-size(1), n::binary()>> = _move | tail], [{xa,ya}|_] = path) do
    m = String.to_integer(n)

    {xb, yb} = case dir do
      "L" -> {xa - m, ya}
      "R" -> {xa + m, ya}
      "D" -> {xa, ya - m}
      "U" -> {xa, ya + m}
    end

    segment = for x <- xb..xa,
                  y <- yb..ya,
                  (x != xa or y != ya) do
          {x,y}
        end

    path = segment ++ path
    get_path(tail, path)
  end

  def get_taxicab_distance({xa, ya}, {xb, yb} \\ {0, 0}) do
    abs(xa - xb) + abs(ya - yb)
  end

  def count_steps_to_intersections([red, green], intersections) do
    intersections
      |> Enum.map(fn i ->
        r = Enum.find_index(red, fn p-> p == i end)
        g = Enum.find_index(green, fn p -> p == i end)

        (r+1) + (g+1)
      end)
  end

end
