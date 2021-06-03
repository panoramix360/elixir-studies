defmodule LineSigil do

  def sigil_v(lines, _opts) do
    lines
    |> String.trim_trailing
    |> String.split("\n")
    |> Enum.map(fn list ->
      String.split(list, ",")
    end)
  end
end

defmodule Example do
  import LineSigil

  def lines do
    ~v"""
    1,2,3
    cat,dog
    """
  end
end

IO.inspect Example.lines
