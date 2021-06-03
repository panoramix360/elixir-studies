defmodule Stack.ServerTest do
  use ExUnit.Case
  alias Stack.Server

  test "can pop list" do
    assert 9 == Server.pop
    assert "cat" == Server.pop
    assert 5 == Server.pop
    assert [] == Server.pop
  end

  test "can push list" do
    Server.push 10

    assert 10 == Server.pop
    assert [] == Server.pop
  end
end
