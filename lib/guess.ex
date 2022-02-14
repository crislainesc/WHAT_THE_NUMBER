defmodule Guess do
  use Application

  def start(_, _) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.puts("Let's play What The Number!")

    IO.gets("Escolha um nivel de difuculdade (1, 2 ou 3): ")
    |> Integer.parse()
    |> parse_input()
    |> get_range()
    |> IO.inspect()
  end

  def parse_input(:error) do
    IO.puts("Entrada invalida!!")
    run()
  end

  def parse_input({num, _}), do: num

  def get_range(level) do
    case level do
      1 -> 1..10
      2 -> 1..100
      3 -> 1..1000
      _ -> IO.puts("Nivel invalido!!")
      run()
    end
  end

end
