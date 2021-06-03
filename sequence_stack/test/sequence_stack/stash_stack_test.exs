defmodule Stack.StashTest do
  use ExUnit.Case
  alias Stack.Stash

  test "can save stash" do
    stash = [1, 2, 3]
    Stash.update(stash)

    assert stash == Stash.get

    Stash.update([1, 2])
    assert stash != Stash.get
  end
end
