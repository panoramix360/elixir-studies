defmodule SpawnExercise2 do
  def greet(pid, token) do
    receive do
      {} ->
        send pid, token
    end
  end
end

pid1 = spawn(SpawnExercise2, :greet, [self(), "fredyyy"])
pid2 = spawn(SpawnExercise2, :greet, [self(), "betty"])

send pid1, {}
receive do
  token ->
    IO.puts token
end

send pid2, {}
receive do
  token ->
    IO.puts token
end
