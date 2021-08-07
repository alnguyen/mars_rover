defmodule Plateau do
  alias Utils.Number

  @type t() :: %__MODULE__{}

  defstruct [:x, :y]

  def new(%{x: x, y: y}) do
    %__MODULE__{
      x: Number.parse_int(x),
      y: Number.parse_int(y)
    }
  end
end
