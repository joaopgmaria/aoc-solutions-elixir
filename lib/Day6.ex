defmodule Day6 do

  @input "priv/inputs/day6.txt"
  defp get_input(), do: File.read!(@input)

  def part1() do
    get_input()
      |> parce_orbits()
      |> get_suborbits()
      |> Map.to_list()
      |> Enum.reduce(0, fn {_, lst}, acc -> acc + Enum.count(lst) end)
  end

  defp parce_orbits(input) do
    input
      |> String.replace("\r", "")
      |> String.split("\n", trim: true)
      |> Enum.map(fn <<a::binary()-size(3), ")", b::binary()-size(3)>> -> {a,b} end)
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

end
