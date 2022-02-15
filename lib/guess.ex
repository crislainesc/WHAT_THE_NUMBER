defmodule Guess do
  use Application

  def start(_, _) do
    run()
    {:ok, self()}
  end

  def run() do
    IO.puts("Let's play What The Number!")

    IO.gets("Escolha um nivel de difuculdade (1, 2 ou 3): ")
    |> parse_input()
    |> pickup_number()
    |> play()
  end

  def play(picked_number) do
    IO.gets("Ja escolhi meu numero. Qual o seu palpite? ")
    |> parse_input()
    |> guess(picked_number, 1)
  end

  def guess(user_guess, picked_number, counter) when user_guess > picked_number do
    IO.gets("Muito alto! Mas voce pode tentar de novo: ")
    |> parse_input()
    |> guess(picked_number, counter + 1)
  end

  def guess(user_guess, picked_number, counter) when user_guess < picked_number do
    IO.gets("Esta bem abaixo do que eu pensei... Tente de novo: ")
    |> parse_input()
    |> guess(picked_number, counter + 1)
  end

  def guess(_user_guess, _picked_number, counter) do
    IO.puts("Incrivel. Voce acertou! #{counter} tentativas.")
    show_score(counter)
  end

  def show_score(guesses) do
    {_, message} = %{1..1 => "Voce consegue mesmo ler mentes!",
    2..4 => "Muito interessante...",
    5..6 => "Voce consegue fazer melhor que isso!",
    7..50 => "Mais sorte na proxima..."}
    |> Enum.find(fn {range, _} ->
      Enum.member?(range, guesses)
    end)
    IO.puts(message)
  end

  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
  end

  def parse_input(:error) do
    IO.puts("Entrada invalida!!")
    run()
  end

  def parse_input({num, _}), do: num

  def parse_input(data) do
    data
    |> Integer.parse()
    |> parse_input()
  end

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
