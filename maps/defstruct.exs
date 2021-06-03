defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end

defmodule Main do
  def main do
    s1 = %Subscriber{}

    s2 = %Subscriber{ name: "Dave" }

    s3 = %Subscriber{ name: "Mary", paid: true }

    IO.inspect s1
    IO.inspect s2
    IO.inspect s3
  end
end

Main.main
