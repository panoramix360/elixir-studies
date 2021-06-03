defmodule LineSigil do

  def sigil_v(lines, _opts) do
    lines
    |> String.split("\n", trim: true)
    |> process_lines
  end

  defp process_lines([ head | tail ]) do
    headers = String.split(head, ",") |> Enum.map(&(String.to_atom/1))
    tail
    |> Enum.map(fn line ->
      String.split(line, ",")
      |> process_row(headers)
    end)
  end

  defp process_row(row, headers) do
    Enum.zip(headers, row)
  end
end

defmodule Example do
  import LineSigil

  def lines do
    ~v"""
    Item,Qty,Price
    Teddy bear,4,34.95
    Milk,1,2.99
    Battery,6,8.00
    """
  end
end

IO.inspect Example.lines
