defmodule SpawnExercise3 do
  import :timer, only: [ sleep: 1 ]

  def report(pid) do
    IO.inspect pid
    send pid, self()
    raise "Error"
    exit(:boom)
  end

  def run do
    spawn_link(SpawnExercise3, :report, [self()])

    sleep 500

    receive do
      msg ->
        IO.inspect msg
      after 1000 ->
        IO.puts "nothing happened"
    end

  end
end

SpawnExercise3.run
