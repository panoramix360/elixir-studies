defmodule SequenceStack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      { Stack.Stash, Application.get_env(:sequence_stack, :initial_stack) },
      { Stack.Server, nil },
    ]

    opts = [strategy: :rest_for_one, name: SequenceStack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
