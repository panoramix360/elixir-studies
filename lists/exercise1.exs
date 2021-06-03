defmodule MyList do
  def mapsum([], _) do
    0
  end

  def mapsum([head | tail], func) do
    func.(head) + mapsum(tail, func)
  end
end


IO.puts MyList.mapsum [1, 3, 2], &(&1 * &1)
