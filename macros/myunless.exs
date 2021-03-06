defmodule My do
  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)

    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(do_clause)
      end
    end
  end
end


defmodule Test do
  require My

  My.unless is_integer("hello") do
    IO.puts "not an int"
  end
end
