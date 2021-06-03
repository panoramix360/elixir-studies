defmodule MyList do
  def max([x]) do
    x
  end

  def max([head | tail]) do
    Kernel.max(head, max(tail))
  end
end


IO.puts MyList.max [991]
