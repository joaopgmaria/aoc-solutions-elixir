defmodule Day2 do

  @input "priv/inputs/day2.txt"
  defp get_input(), do: File.read!(@input)

  def part1() do
    get_input()
      |> get_program()
      |> compute()
  end

  def part2(implementation \\ :beam) do
    get_input()
      |> get_program()
      |> get_params(19690720, implementation)
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

  def get_params(program, expected, :comprehension) do
    try do
      for noun <- 1..99,
          verb <- 1..99 do
        program = replace(program, 1, noun)
        program = replace(program, 2, verb)

        case compute(program) do
          [actual|_] when actual == expected ->
            throw({:noun, noun, :verb, verb, :result, actual})
          _ -> :noop
        end
      end
    catch
      x -> x
    end
  end

  def get_params(program, expected, :beam) do
    pid = self()

    for noun <- 1..99,
        verb <- 1..99 do

        spawn fn ->
          program = replace(program, 1, noun)
          program = replace(program, 2, verb)

          case compute(program) do
            [actual|_] when actual == expected ->
              send pid, {:noun, noun, :verb, verb, :result, actual}
            other -> other
          end
        end
    end

    receive do
      {:noun, noun, :verb, verb, :result, actual} -> {:noun, noun, :verb, verb, :result, actual}
    after
      5_000 -> {:error, :cannot_find_solution}
    end
  end

  def get_params(program, expected, :recursion) do
    get_params_rec(program, expected, 1, 1)
  end

  defp get_params_rec(_, _, 99, 100) do
    {:error, :cannot_find_solution}
  end
  defp get_params_rec(program, expected, noun, 100) do
    get_params_rec(program, expected, noun + 1, 1)
  end
  defp get_params_rec(program, expected, noun, verb) do
    program = replace(program, 1, noun)
    program = replace(program, 2, verb)

    case compute(program) do
      [actual|_] when actual == expected -> {:noun, noun, :verb, verb, :result, actual}
      _ -> get_params_rec(program, expected, noun, verb+1)
    end
  end
end
