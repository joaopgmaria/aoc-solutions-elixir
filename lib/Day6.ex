defmodule Day6 do

  @input "priv/inputs/day6.txt"
  defp get_input(), do: File.read!(@input)

  def part1(input \\ nil) do
    (input || get_input())
      |> parce_orbits()
      |> get_suborbits()
      |> Map.to_list()
      |> Enum.reduce(0, fn {_, lst}, acc -> acc + Enum.count(lst) end)
  end

  def part2(input \\ nil) do
    [{"SAN",san},{"YOU",you}] =
      (input || get_input())
        |> parce_orbits()
        |> get_suborbits()
        |> Map.to_list()
        |> Enum.filter(fn {o, _} -> o == "SAN" or o == "YOU" end)

    intersection = get_intersection(san, you)

    {_,san} = Enum.split_while(san, & &1 != intersection)
    {_,you} = Enum.split_while(you, & &1 != intersection)

    Enum.count(san) + Enum.count(you) - 2
  end

  defp parce_orbits(input) do
    input
      |> String.replace("\r", "")
      |> String.split("\n", trim: true)
      |> Enum.map(fn a ->
        [a,b] = String.split(a, ")")
        {a,b}
      end)
  end

  def get_suborbits(map) do
    get_suborbits(map, map, %{})
  end

  def get_suborbits([{a,b}|tail], map, acc) do
    orbits = trace(map, a, acc)
    acc = Map.put(acc, b, orbits)
    get_suborbits(tail, map, acc)
  end

  def get_suborbits([], _, acc) do
    acc
  end

  def trace(fullmap, obj, map, acc \\ []) do
    acc = [obj|acc]

    cond do
      (orbits = Map.get(map, obj)) != nil ->
        orbits ++ acc

      (orbit = Enum.find(fullmap, fn {_,p} -> p == obj end)) != nil ->
        {h,_} = orbit
        trace(fullmap, h, map, acc)

      true ->
        acc
    end
  end

  def get_intersection([s,s2|_st], [y,y2|_yt]) when s == y and s2 != y2 do
    s
  end

  def get_intersection([_|st], [_|yt]) do
    get_intersection(st, yt)
  end
end
