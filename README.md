# AdventOfCode solutions in Elixir

**An attempt at [Advent Of Code](https://adventofcode.com/) using Elixir**

## Run

```cmd
iex -S mix
```

```elixir
Day1.part1()
Day1.part2()
...
Dayn.partn()
```

## Test

Run all tests
```cmd
mix test
```

Run exercise (day) specific tests
```cmd
mix test --only day:1
```

## Benchmark

There are some exercises where I iterated multiple times with different solutions.<br>
All of the solutions were kept (when meaninfull) and can be called individually:
```elixir
Day2.part2(:comprehension)
Day2.part2(:recursion)
```

If you want to [benchmark](https://github.com/bencheeorg/benchee) differences use:
```elixir
Benchee.run(
    %{
        "comprehension" => fn -> Day2.part2(:comprehension) end,
        "recursion" => fn -> Day2.part2(:recursion) end,
        "beam processes" =>  fn -> Day2.part2(:beam) end
    }
)
```