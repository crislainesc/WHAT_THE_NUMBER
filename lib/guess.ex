defmodule Guess do
  use Application

  def start(_, _) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.puts("Let's play What The Number!")

    IO.gets("Escolha um nivel de difuculdade (1, 2 ou 3): ")
    |> IO.inspect()
  end
end
