defmodule SaleTaxReader do
  def parse_file(filename) do
    file = File.open!(filename)
    headers = read_headers(IO.read(file, :line))
    Enum.map(IO.stream(file, :line), &(create_one_row(headers, &1)))
  end

  defp read_headers(headers) do
    from_csv_and_map(headers, &(String.to_atom(&1)))
  end

  defp from_csv_and_map(row_csv, mapper) do
    row_csv
    |> String.trim
    |> String.split(",")
    |> Enum.map(&(mapper.(&1)))
  end

  defp create_one_row(headers, row) do
    row_csv = row
    |> String.trim
    |> String.split(",")
    Enum.zip(headers, row_csv)
  end


end

IO.inspect SaleTaxReader.parse_file("sales.txt")
