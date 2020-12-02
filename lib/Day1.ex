defmodule Day1 do
  @input "priv/inputs/day1.txt"
  def get_input(nil) do
    File.read!(@input)
  end

  def get_input(str), do: str

  def part1(input \\ "") do
    get_input(input)
    |> get_numbers()
    |> get_tuples(2)
    |> filter_sum(2020)
    |> multiply()
  end

  def part2(input \\ "") do
    get_input(input)
    |> get_numbers()
    |> get_tuples(3)
    |> filter_sum(2020)
    |> multiply()
  end

  def get_numbers(input) do
    input
    |> String.replace("\r", "")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def get_tuples(list, 2) do
    for a <- list,
        b <- list do
      {a, b}
    end
  end

  def get_tuples(list, 3) do
    for a <- list,
        b <- list,
        c <- list do
      {a, b, c}
    end
  end

  def filter_sum(list, res) do
    Enum.filter(list, fn t ->
      res ==
        t
        |> Tuple.to_list()
        |> Enum.sum()
    end)
    |> hd()
  end

  def multiply(t) do
    t
    |> Tuple.to_list()
    |> Enum.reduce(1, fn v, acc ->
      acc * v
    end)
  end
end
