defmodule Day4 do
  @input "156218-652527"

  def part1(input \\ @input) do
    brute_force(input, &is_valid?/1)
  end

  def part2(input \\ @input) do
    brute_force(input, &is_more_valid?/1)
  end

  def brute_force(input, f) do
    [l,h] = input
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    for i <- l..h,
        p = Integer.to_string(i),
        f.(p) do
      p
    end |> Enum.count()
  end

  def is_valid?(<<pwd::binary()-size(6)>>) do
    init = String.codepoints(pwd)

    sorted = Enum.sort(init)
    sorted == init and Enum.dedup(init) != init
  end

  def is_more_valid?(<<pwd::binary()-size(6)>>) do
    init = String.codepoints(pwd)

    Enum.sort(init) == init and
    Enum.any?(init, fn p -> Enum.count(init, fn q -> q == p end) == 2 end)
  end
end
