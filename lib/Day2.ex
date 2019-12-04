defmodule Day2 do
  @input "priv/inputs/day2.txt"
  defp get_input(), do: File.read!(@input)

  def part1() do
    get_input()
      |> get_program()
      |> compute()
  end

  defp get_program(input) do
    input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def compute(program, ip \\ 0) do
    {_, opcodes} = Enum.split(program, ip)

    case execute(opcodes, program) do
      {:ok, p} -> compute(p, ip + 4)
      {:stop, p} -> p
    end
  end

  def execute([99|_], program) do
    {:stop, program}
  end

  def execute([op, lidx, ridx, dst|_], program) do
    lhs = Enum.at(program, lidx)
    rhs = Enum.at(program, ridx)

    val = case op do
      1 -> lhs + rhs
      2 -> lhs * rhs
    end

    {:ok, replace(program, dst, val)}
  end

  defp replace(lst, idx, val) do
    {left, [_|right]} = Enum.split(lst, idx)
    left ++ [val|right]
  end
end
