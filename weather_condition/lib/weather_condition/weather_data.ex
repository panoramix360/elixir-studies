defmodule WeatherCondition.WeatherData do
  require Logger

  @weather_url Application.get_env(:weather_condition, :weather_url)

  @doc """
    Method that fetches weather data from the server
  """
  def fetch(state) do
    Logger.info("Fetching weather from #{state}")

    data_url(state)
    |> HTTPoison.get
    |> handle_response
  end

  def data_url(state) do
    "#{@weather_url}/#{state}.xml"
  end

  def handle_response({ _, %{status_code: status_code, body: body} }) do
    Logger.info("Got response: status code=#{status_code}")
    Logger.debug(fn -> inspect(body) end)

    {
      status_code |> check_for_error(),
      body
    }
  end

  def check_for_error(200), do: :ok
  def check_for_error(_), do: :error
end
