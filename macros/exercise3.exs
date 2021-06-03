defmodule Ex.Explain do
  def process_expr(operator, left, right) when is_integer(left) do
    process_expr(right) <> " then #{translate_operator(operator)} #{left}"
  end

  def process_expr(operator, left, right) when is_integer(right) do
    process_expr(left) <> " then #{translate_operator(operator)} #{right}"
  end

  def process_expr({ operator, _, [left, right] }) when is_integer(left) and is_integer(right) do
    "#{translate_operator(operator)} #{left} and #{right},"
  end

  defmacro explain([{ :do, { operator, _, [left, right] } }] = _) do
    IO.puts process_expr(operator, left, right)
  end

  def translate_operator(op) do
    case op do
      :+ ->
        "add"
      :* ->
        "multiply"
      :/ ->
        "divide"
      :- ->
        "subtract"
    end
  end
end
