defmodule StringUtils do
  def center(list) do
    longest_num = discover_longest(list, 0)
    print_center(list, longest_num)
  end

  defp print_center([], _), do: []
  defp print_center([ head | tail ], num) do
    leading_count = div(num - String.length(head), 2)
    IO.puts "#{String.duplicate(" ", leading_count)}#{head}"
    print_center(tail, num)
  end

  defp discover_longest([], num), do: num
  defp discover_longest([ head | tail], num) do
    if String.length(head) > num do
      discover_longest(tail, String.length(head))
    else
      discover_longest(tail, num)
    end
  end
end

StringUtils.center(~w{cat zebra elephant})
