prefix = fn s ->
  fn s2 -> "#{s} #{s2}" end
end

mrs = prefix.("Mrs")

IO.puts mrs.("Smith")

IO.puts prefix.("Elixir").("Rocks")
