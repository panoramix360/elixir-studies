defmodule MustBe do
  def ok!({ :ok, data }), do: data
  def ok!({ error_type, error_msg }), do: raise("#{error_type}: #{error_msg}")
end

IO.inspect MustBe.ok!
