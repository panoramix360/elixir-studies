defmodule CliTest do
  use ExUnit.Case
  doctest WeatherCondition


  import WeatherCondition.CLI, only: [ parse_args: 1, process: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "test if state is processed" do
    assert parse_args(["--state=KNID"]) == { "KNID" }
    assert parse_args(["--state", "KAAA"]) == { "KAAA" }
    assert parse_args(["--state", "KAAA", "anything"]) == { "KAAA" }
  end

  test "test parse args without arguments" do
    assert parse_args([""]) == :error
    assert parse_args([]) == :error
    assert parse_args(["anything"]) == :error
  end

  test "process" do
    IO.inspect process({ "KAAT" })
  end
end
