defmodule Duper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Duper.Results,
      { Duper.PathFinder, "/home/lucas/projects" },
      Duper.WorkerSupervisor,
      { Duper.Gatherer, 50 }
    ]

    opts = [strategy: :one_for_all, name: Duper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
