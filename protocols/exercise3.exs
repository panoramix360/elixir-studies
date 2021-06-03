defmodule OwnEnumerable do
  def each(map, fun) do
    Enum.reduce(map, nil, fn item, _ ->
      fun.(item)
    end)
  end

  def filter(map, fun) do
    Enum.reduce(map, [], fn item, acc ->
      if fun.(item) do
        [item | acc]
      else
        acc
      end
    end)
  end

  def map(map, fun) do
    Enum.reduce(map, [], fn item, acc ->
      [fun.(item) | acc]
    end)
  end
end

OwnEnumerable.each(["some", "example"], fn x -> IO.puts(x) end)

IO.inspect OwnEnumerable.filter([1, 2, 3, 4, 5, 6, 7, 8], fn x -> rem(x, 2) == 0 end)

IO.inspect OwnEnumerable.map([1, 2, 3], fn x -> x * 2 end)
