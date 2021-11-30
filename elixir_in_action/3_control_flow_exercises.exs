defmodule ControlFlowExercises1 do
  def list_len(list) do
    do_len(0, list)
  end

  defp do_len(current, []), do: current
  defp do_len(current, [ _ | tail]) do
    do_len(current + 1, tail)
  end

  def range(from, to) do
    calc_range(from, to, [])
  end

  def calc_range(from, to, list) when from > to, do: Enum.reverse(list)
  def calc_range(from, to, list) do
    calc_range(from + 1, to, [ from | list ])
  end

  def positive(list) do
    calc_positive(list, [])
  end

  def calc_positive([], acc), do: Enum.reverse(acc)
  def calc_positive([ head | tail], acc) when head > 0 do
    calc_positive(tail, [ head | acc ])
  end
  def calc_positive([ _head | tail ], acc), do: calc_positive(tail, acc)
end


defmodule ControlFlowExercises2 do

  @test_file "#{__DIR__}/test_file"

  def test_file do
    @test_file
  end

  def filterable_file(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  def large_lines!(path) do
    filterable_file(path)
    |> Enum.filter(&String.length(&1) > 80)
  end

  def lines_length!(path) do
    filterable_file(path)
    |> Enum.map(&String.length/1)
  end

  def longest_line_length!(path) do
    filterable_file(path)
    |> Stream.map(&String.length/1)
    |> Enum.reduce(0, &max/2)
  end

  def longest_line!(path) do
    filterable_file(path)
    |> Enum.reduce("", &is_longer_line/2)
  end

  def words_per_line!(path) do
    filterable_file(path)
    |> Enum.map(&words_count/1)
  end

  defp is_longer_line(line, acc) do
    if String.length(line) > String.length(acc) do
      line
    else
      acc
    end
  end

  defp words_count(line) do
    line
    |> String.split(" ")
    |> length
  end
end
