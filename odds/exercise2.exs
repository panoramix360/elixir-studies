defmodule LineSigil do

  def sigil_v(lines, _opts) do
    lines
    |> String.split("\n", trim: true)
    |> Enum.map(fn list ->
      String.split(list, ",")
      |> parse_list
    end)
  end

  defp parse_list(list) do
    list
    |> Enum.map(fn char ->
      parse(char, Float.parse(char))
    end)
  end

  defp parse(char, :error) do
    char
  end

  defp parse(_char, { num_float, _ }) do
    num_float
  end
end

defmodule Example do
  import LineSigil

  def lines do
    ~v"""
    1,2,3.14
    cat,dog
    """
  end
end

IO.inspect Example.lines
