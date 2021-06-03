defmodule Sequence.Server do
  use GenServer
  require Logger

  @vsn "2"

  defmodule State do
    defstruct(current_number: 0, delta: 1)
  end

  ####
  # External API

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def next_number do
    with number = GenServer.call(__MODULE__, :next_number),
    do: "The next number is #{number}"
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, { :increment_number, delta }
  end

  def terminate do
    GenServer.cast __MODULE__, :terminate
  end

  ####
  # GenServer implementation

  def init(_) do
    stash_state = Sequence.Stash.get()
    state = %State{ current_number: stash_state.current_number, delta: stash_state.delta }
    { :ok, state }
  end

  def handle_call(:next_number, _from, state = %{ current_number: n }) do
    { :reply, n, %{state | current_number: n + state.delta} }
  end

  def handle_call({ :set_number, new_number }, _from, _current_number) do
    { :reply, new_number, new_number }
  end

  def handle_cast({ :increment_number, delta }, state) do
    { :noreply, %{state | delta: delta} }
  end

  def handle_cast({ :terminate }, state) do
    System.halt(0)
    { :noreply, state }
  end

  def terminate(_reason, state) do
    Sequence.Stash.update(state.current_number, state.delta)
  end

  def format_status(_reason, [ _pdict, state ]) do
    [ data: [ { 'State', "My current state is '#{inspect state}', and I'm happy" } ] ]
  end

  def code_change("0", old_state = current_number, _extra) do
    new_state = %State{
      current_number: current_number,
      delta: 1
    }

    Logger.info "Changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)

    { :ok, new_state }
  end
end
