defmodule Chop do
  def guess(n, range = a..b) do
    guess_num = div(a + b, 2)
    IO.puts "Is it #{guess_num}"
    guess(n, guess_num, range)
  end

  defp guess(n, n, _) do
    IO.puts n
  end

  defp guess(n, guess, _..b) when n > guess do
    guess(n, guess + 1..b)
  end

  defp guess(n, guess, a.._) when n < guess do
    guess(n, a..guess - 1)
  end
end


Chop.guess(444, 1..1000)
