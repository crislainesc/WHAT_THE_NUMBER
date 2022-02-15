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

  def pickup_number(level) do
    level
    |> get_range()
    |> Enum.random()
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

  def play(picked_number) do
    IO.gets("Ja escolhi meu numero. Qual o seu palpite? ")
    |> parse_input()
    |> guess(picked_number, 1)
  end

  def guess(user_guess, picked_number, counter)when user_guess == picked_number do
    IO.puts("Incrivel. Acertou com #{counter} tentativas.")
    show_score(counter)
  end

  def guess(user_guess, picked_number, counter) do
    if user_guess > picked_number do
      IO.gets("Muito alto! Mas voce pode tentar de novo: ")
    else
      IO.gets("Muito baixo! Tente de novo: ")
    end
    |> parse_input()
    |> guess(picked_number, counter + 1)
  end


  def show_score(guesses) when guesses > 6 do
    IO.puts("Mais sorte na proxima...")
  end

  def show_score(guesses) do
    {_, message} = %{1..1 => "Voce consegue mesmo ler mentes!",
    2..4 => "Muito interessante...",
    5..6 => "Voce consegue fazer melhor que isso!"}
    |> Enum.find(fn {range, _} ->
      Enum.member?(range, guesses)
    end)
    IO.puts(message)
  end

end
