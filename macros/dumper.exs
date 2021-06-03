defmodule My do
  defmacro macro(param) do
    IO.inspect param
  end
end

defmodule Test do
  require My

  # These values represent themselves
  My.macro :atom      #=> :atom
  My.macro 1          #=> 1
  My.macro 1.0        #=> 1.0
  My.macro [1,2,3]    #=> [1, 2, 3]
  My.macro "binaries" #=> "binaries"
  My.macro { 1, 2 }   #=> {1,2}
  My.macro do: 1      #=> [do: 1]

  My.macro { 1, 2, 3, 4, 5 }

  My.macro do: ( a = 1; a+a )

  My.macro do
    1 + 2
  else
    3 + 4
  end
end
