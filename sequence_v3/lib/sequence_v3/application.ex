defmodule SequenceV3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      { Sequence.Stash, Application.get_env(:sequence_v3, :initial_number) },
      { Sequence.Server, nil },
      { Stack.Stash, [9, "cat", 5] },
      { Stack.Server, nil },
    ]

    opts = [strategy: :rest_for_one, name: SequenceV3.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
