defmodule Stack.Stash do
  use GenServer

  @me __MODULE__

  def start_link(stash) do
    GenServer.start_link(__MODULE__, stash, name: @me)
  end

  def get do
    GenServer.call(@me, { :get })
  end

  def update(new_stash) do
    GenServer.cast(@me, { :update, new_stash })
  end

  # Server implementation

  def init(initial_stash) do
    { :ok, initial_stash }
  end

  def handle_call({ :get }, _from, stash) do
    { :reply, stash, stash }
  end

  def handle_cast({ :update, new_stash }, _stash) do
    { :noreply, new_stash }
  end
end
