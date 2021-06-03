defmodule Sequence.Stash do
  use GenServer

  @me __MODULE__

  @vsn "0"

  defmodule State do
    defstruct(current_number: 0, delta: 1)
  end

  def start_link(initial_number) do
    GenServer.start_link(__MODULE__, initial_number, name: @me)
  end

  def get do
    GenServer.call(@me, { :get })
  end

  def update(new_number, delta) do
    GenServer.cast(@me, { :update, new_number, delta })
  end

  # Server implementation

  def init(initial_number) do
    { :ok, %State{ current_number: initial_number } }
  end

  def handle_call({ :get }, _from, state) do
    { :reply, state, state }
  end

  def handle_cast({ :update, new_number, new_delta }, state) do
    { :noreply, %State{state | current_number: new_number, delta: new_delta } }
  end
end
