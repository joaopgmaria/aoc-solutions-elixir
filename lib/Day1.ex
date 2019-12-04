defmodule Day1 do

  @input "priv/inputs/day1.txt"
  defp get_input(), do: File.read!(@input)

  def part1() do
    get_input()
      |> get_masses()
      |> Enum.reduce(0, fn mass, acc -> acc + get_fuel(mass) end)
  end

  defp get_masses(input) do
    input
      |> String.replace("\r", "")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def get_fuel(mass), do: Kernel.trunc(mass/3)-2
end
