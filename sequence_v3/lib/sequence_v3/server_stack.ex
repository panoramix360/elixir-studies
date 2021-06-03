defmodule Stack.Server do
  use GenServer

  ####
  # External API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(value) do
    GenServer.cast __MODULE__, { :push, value }
  end

  def terminate do
    GenServer.cast __MODULE__, { :terminate }
  end

  ####
  # GenServer implementation

  def init(_) do
    { :ok, Stack.Stash.get() }
  end

  def handle_call(:pop, _from, []) do
    { :reply, [], [] }
  end

  def handle_call(:pop, _from, [ head | tail ]) do
    { :reply, head, tail }
  end

  def handle_cast({ :push, value }, stack) do
    { :noreply, [value] ++ stack }
  end

  def handle_cast({ :terminate }, _stash) do
    raise "fail"
  end

  def terminate(_reason, stack) do
    Stack.Stash.update(stack)
  end
end
