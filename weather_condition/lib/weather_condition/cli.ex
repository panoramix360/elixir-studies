defmodule WeatherCondition.CLI do
  require Record
  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")
  @moduledoc """
  Handle the commandline parsing and the dispatch
  to other functions that generate the result
  """

  @doc """
    Main function to process data
  """
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def process(:help) do
    IO.puts """
    usage: weather_condition --state=VOO
    """
    System.halt(0)
  end

  def process({ state }) do
    WeatherCondition.WeatherData.fetch(state)
    |> decode_response()
    |> parse_xml()
    |> print_table()
  end

  def decode_response({ :ok, body }), do: body
  def decode_response({ :error }) do
    IO.puts "Error fetching weather data"
    System.halt(2)
  end

  def parse_xml(body) do
    { doc, [] } = body |> to_charlist() |> :xmerl_scan.string()
    %{
      location: extract_path('/current_observation/location/text()', doc),
      last_updated: extract_path('/current_observation/observation_time/text()', doc),
      weather: extract_path('/current_observation/weather/text()', doc),
      temperature: extract_path('/current_observation/temperature_string/text()', doc),
      dewpoint: extract_path('/current_observation/dewpoint_string/text()', doc),
      relative_humidity: extract_path('/current_observation/relative_humidity/text()', doc),
      wind: extract_path('/current_observation/wind_string/text()', doc),
      visibility: extract_path('/current_observation/visibility_mi/text()', doc)
    }
  end

  def extract_path(path, doc) do
    :xmerl_xpath.string(path, doc)
    |> extract_text
  end

  defp extract_text([xmlText(value: value)]), do: List.to_string(value)
  defp extract_text(_x), do: nil

  def print_table(%{ location: location,
                      last_updated: last_updated,
                      weather: weather,
                      temperature: temperature,
                      dewpoint: dewpoint,
                      relative_humidity: relative_humidity,
                      wind: wind,
                      visibility: visibility }) do
    IO.puts "Location: #{location}"
    IO.puts "Last Updated: #{last_updated}"
    IO.puts "Weather: #{weather}"
    IO.puts "Temperature: #{temperature}"
    IO.puts "Dewpoint: #{dewpoint}"
    IO.puts "Relative Humidity: #{relative_humidity} %"
    IO.puts "Wind: #{wind}"
    IO.puts "Visibility: #{visibility}"
  end

  @doc """
    `argv` can be -h or --help, which returns :help

    Otherwise it is a github user name, project name, and
    (optionally)
    the number of entries to format

    Return a tuple of `{ user, project, count }` or `:help` if help was given
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [ help: :boolean, state: :string ], aliases: [ h: :help, s: :state ])
      |> elem(0)
      |> args_to_internal_representation
  end

  @doc """
    Handle arguments passed by OptionParser
  """
  def args_to_internal_representation([ state: state ]) do
    { state }
  end

  def args_to_internal_representation([ help: true ]), do: :help
  def args_to_internal_representation(_), do: :error
end
