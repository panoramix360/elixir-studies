defmodule Fib do
  def of(0), do: 0
  def of(1), do: 1
  def of(n), do: Fib.of(n - 1) + Fib.of(n - 2)
end

IO.puts "Start the task"
worker = Task.async(fn -> Fib.of(20) end)

IO.puts "Do something else"

IO.puts "Wait for the task"
result = Task.await(worker)

IO.puts "The result is #{result}"

IO.puts "[2] Start the task"
worker_2 = Task.async(Fib, :of, [20])

IO.puts "[2] Do something else"

IO.puts "[2] Wait for the task"
result_2 = Task.await(worker_2)

IO.puts "[2] The result is #{result_2}"
