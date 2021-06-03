defmodule KinectProtocolError do
  defexception message: "Kinect protocol error", can_retry: false

  def full_message(me) do
    "Kinect failed #{me.message}, retriable: #{me.can_retry}"
  end
end

defmodule Test do

  def start do
    try do
      test()
    rescue
      error in [ KinectProtocolError ] ->
        IO.puts KinectProtocolError.full_message(error)
        if error.can_retry, do: IO.puts "retry"
    end
  end

  def test do
    raise KinectProtocolError
  end
end

Test.start
