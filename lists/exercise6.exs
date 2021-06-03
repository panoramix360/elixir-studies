defmodule MyEnum do
  def all?(list), do: all?(list, fn x -> !!x end)

  def all?([], _func), do: true

  def all?([head | tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  def each([], _func), do: []
  def each([head | tail], func) do
    [ func.(head) | each(tail, func) ]
  end

  def filter([], _func), do: []
  def filter([ head | tail ], func) do
    if func.(head) do
      [ head | filter(tail, func) ]
    else
      filter(tail, func)
    end
  end

  def split(list, count), do: _split(list, [], count)
  defp _split([], front, _), do: [ Enum.reverse(front), [] ]
  defp _split(tail, front, 0), do: [ Enum.reverse(front), tail ]
  defp _split([ head | tail ], front, count) do
    _split(tail, [ head | front ], count - 1)
  end

  def take(list, count), do: hd(split(list, count))

  def flatten([]), do: []
  def flatten(list) do

  end
end

list = [1, 2, 3, 4, 5]

IO.inspect MyEnum.all?(list, &(&1 < 4))

MyEnum.each(["some", "example"], fn x -> IO.puts(x) end)

IO.inspect MyEnum.filter(list, &(&1 <= 3))

IO.inspect MyEnum.split(list, 3)

IO.inspect MyEnum.take(list, 2)
