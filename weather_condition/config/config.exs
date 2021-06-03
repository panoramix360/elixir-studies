use Mix.Config

config :weather_condition, weather_url: "https://w1.weather.gov/xml/current_obs"

config :logger, compile_time_purge_matching: [
  [level_lower_than: :info]
]
