defmodule Utils.Number do
  def parse_int(value) when is_binary(value), do: String.to_integer(value)
  def parse_int(value) when is_integer(value), do: value
end
