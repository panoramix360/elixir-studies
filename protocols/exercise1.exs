defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    string
    |> String.to_charlist
    |> Enum.map(&Char.shift_letter(&1, shift))
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

defimpl Caesar, for: List do
  def encrypt(string, shift) do
    string
    |> Enum.map(&Char.shift_letter(&1, shift))
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

defmodule Char do
  def shift_letter(letter, shift) when letter < 0x5b and letter > 0x40 do
    letter + shift
  end

  def shift_letter(letter, shift) when letter < 0x7b and letter > 0x60 do
    letter + shift
  end

  def shift_letter(letter, _), do: letter
end

IO.puts Caesar.encrypt("Hello World!", 1)
IO.puts Caesar.encrypt(String.to_charlist("Hello"), 1)
