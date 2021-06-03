defmodule WeatherDataTest do
  use ExUnit.Case
  doctest WeatherCondition

  import WeatherCondition.WeatherData, only: [ fetch: 1 ]

  test "fetch" do
    WeatherCondition.WeatherData.fetch("KNID")
  end
end
