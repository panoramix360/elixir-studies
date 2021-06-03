defmodule Exercise do
  def gdc(x, 0), do: x
  def gdc(x, y), do: gdc(y, rem(x, y))
end

IO.puts Exercise.gdc(2, 0)

IO.puts Exercise.gdc(100, 5000)
