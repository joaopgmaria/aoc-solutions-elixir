defmodule Day5 do

  @input "priv/inputs/day5.txt"
  defp get_input(), do: File.read!(@input)

  def part1() do
    get_input()
      |> get_program()
      |> compute()
  end

  def test(input) do
    input
    |> get_program()
    |> compute()
  end

  defp get_program(input) do
    input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  def compute(program, ip \\ 0) do
    case execute(program, ip) do
      {:ok, p, i} -> compute(p, i)
      {:stop, p, _} -> p
    end
  end

  def execute(program, ip) do
    {_, opcode} = Enum.split(program, ip)
    [o|params] = opcode
    {m3,m2,m1,op} = parse_modes(o)

    execute_instruction(op, params, {m1,m2,m3}, program, ip)
  end

  def execute_instruction(1, [p1,p2,p3|_], {m1,m2,_}, program, ip) do
    v1 = get_param(program, p1, m1)
    v2 = get_param(program, p2, m2)

    updated = program |> replace(p3, v1+v2)

    {:ok, updated, ip + 4}
  end

  def execute_instruction(2, [p1,p2,p3|_], {m1,m2,_}, program, ip) do
    v1 = get_param(program, p1, m1)
    v2 = get_param(program, p2, m2)

    updated = program |> replace(p3, v1*v2)

    {:ok, updated, ip + 4}
  end

  def execute_instruction(3, [idx|_], _, program, ip) do
    val = IO.gets("Input: ")
      |> String.replace("\r","")
      |> String.replace("\n","")
      |> String.to_integer()

    updated = program |> replace(idx, val)

    {:ok, updated, ip + 2}
  end

  def execute_instruction(4, [idx|_], {m1,_,_}, program, ip) do
    val = get_param(program, idx, m1)
    IO.puts("Value: #{val}")

    {:ok, program, ip + 2}
  end

  def execute_instruction(5, [p1,p2|_], {m1,m2,_}, program, ip) do
    new_ip = case get_param(program, p1, m1) do
      val when val != 0 -> get_param(program, p2, m2)
      _ -> ip+3
    end

    {:ok, program, new_ip}
  end

  def execute_instruction(6, [p1,p2|_], {m1,m2,_}, program, ip) do
    new_ip = case get_param(program, p1, m1) do
      val when val == 0 -> get_param(program, p2, m2)
      _ -> ip+3
    end

    {:ok, program, new_ip}
  end

  def execute_instruction(7, [p1,p2,p3|_], {m1,m2,_}, program, ip) do
    v1 = get_param(program, p1, m1)
    v2 = get_param(program, p2, m2)

    updated = case v1 < v2 do
      true -> replace(program, p3, 1)
      false -> replace(program, p3, 0)
    end

    {:ok, updated, ip + 4}
  end

  def execute_instruction(8, [p1,p2,p3|_], {m1,m2,_}, program, ip) do
    v1 = get_param(program, p1, m1)
    v2 = get_param(program, p2, m2)

    updated = case v1 == v2 do
      true -> replace(program, p3, 1)
      false -> replace(program, p3, 0)
    end

    {:ok, updated, ip + 4}
  end

  def execute_instruction(99, _, _, program, ip) do
    {:stop, program, ip}
  end

  defp replace(lst, idx, val) do
    {left, [_|right]} = Enum.split(lst, idx)
    left ++ [val|right]
  end

  def get_param(program, idx, 0), do: Enum.at(program, idx)
  def get_param(_, val, 1), do: val

  def parse_modes(opcode) do
    m3 = div(opcode, 10000)
    r3 = rem(opcode, 10000)

    m2 = div(r3, 1000)
    r2 = rem(r3, 1000)

    m1 = div(r2, 100)
    op = rem(r2, 100)

    {m3, m2, m1, op}
  end

end
