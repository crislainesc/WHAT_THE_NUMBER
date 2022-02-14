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
    |> IO.inspect()
  end


  def parse_input(:error) do
    IO.puts("Nivel invalido!!")
    run()
  end

  def parse_input({num, _}), do: num

end
