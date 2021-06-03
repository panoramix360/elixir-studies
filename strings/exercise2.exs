defmodule StringUtil do
  def verify_anagram(str1, str2) do
    Enum.sort(str1) == Enum.sort(str2)
  end
end

IO.puts StringUtil.verify_anagram('cat', 'actor')
