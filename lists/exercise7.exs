defmodule MyList do
  def span(from, to) when from > to do
    []
  end

  def span(from, to) do
    [from | span(from + 1, to)]
  end

  def primes_up_to(n) do
    range = span(2, n)
    range -- (​lc​ ​a​ inlist range, ​b​ inlist range, ​a​ <= ​b​, ​a​*​b​ <= ​n​, ​do​: ​a​*​b​)
  end
end

IO.inspect MyList.primes_up_to(40)
