use Mix.Config

config :mastery_persistence, MasteryPersistence.Repo,
  database: "mastery_dev",
  hostname: "localhost",
  username: "postgres",
  password: "Globo.159951"

config :mastery, :persistence_fn, &MasteryPersistence.record_response/2
