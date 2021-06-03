defmodule StringUtil do
  def check_ascii(str) do
    Enum.all?(str, fn ch -> ch in ? ..?~ end)
  end
end

IO.puts StringUtil.check_ascii('cat!')
IO.puts StringUtil.check_ascii('∂x​/​∂y')
