defmodule StringUtils do
  def capitalize_sentences(sentence) do
    sentence
    |> String.split(". ")
    |> Enum.map(&(String.capitalize(&1)))
    |> Enum.join(". ")
  end
end

IO.puts StringUtils.capitalize_sentences("oh. a DOG. woof. ")
