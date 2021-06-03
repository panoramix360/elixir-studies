defmodule SequenceV3.MixProject do
  use Mix.Project

  def project do
    [
      app: :sequence_v3,
      version: "0.5.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SequenceV3.Application, []},
      env: [ initial_number: 456 ],
      registered: [ Sequence.Server ],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:distillery, "~> 2.1", runtime: false}
    ]
  end
end
