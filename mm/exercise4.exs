defmodule Exercise do
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)
end

IO.puts Exercise.sum(10)
