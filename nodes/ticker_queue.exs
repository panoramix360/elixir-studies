defmodule Ticker do
  @interval 2000 # 2 seconds
  @name :ticker_queue

  def start do
    pid = spawn(__MODULE__, :generator, [[], 0])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients, index) when index <= length(clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients], index)
      after @interval ->
        IO.puts "tick"
        client = Enum.at(clients, index)
        if client do
          send client, { :tick }
        end
        generator(clients, index + 1)
    end
  end

  def generator(clients, _) do
    generator(clients, 0)
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver()
    end
  end
end
