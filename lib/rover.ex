defmodule Rover do
  alias Utils.Number

  @type t() :: %__MODULE__{}

  @enforce_keys [:x, :y, :orientation]
  defstruct [:x, :y, :orientation, :instructions]

  @spec new(map) :: t()
  def new(%{x: x, y: y, orientation: o, instructions: ins}) do
    %__MODULE__{
      x: Number.parse_int(x),
      y: Number.parse_int(y),
      orientation: o,
      instructions: ins
    }
  end

  @spec full_report(t()) :: t()
  def full_report(%__MODULE__{} = rover) do
    current_position(rover)

    rover.instructions
    |> Enum.join("")
    |> IO.puts()

    rover
  end

  def current_position(%__MODULE__{} = rover) do
    IO.puts("#{rover.x} #{rover.y} #{rover.orientation}")
  end

  @spec execute(t()) :: t()
  def execute(%__MODULE__{instructions: []} = rover), do: rover

  def execute(%__MODULE__{orientation: o, instructions: ["L" | rest]} = rover) do
    execute(%{rover | orientation: rotate_ccw(o), instructions: rest})
  end

  def execute(%__MODULE__{orientation: o, instructions: ["R" | rest]} = rover) do
    execute(%{rover | orientation: rotate_cw(o), instructions: rest})
  end

  def execute(%__MODULE__{orientation: "N", instructions: ["M" | rest]} = rover) do
    execute(%{rover | y: rover.y + 1, instructions: rest})
  end

  def execute(%__MODULE__{orientation: "S", instructions: ["M" | rest]} = rover) do
    execute(%{rover | y: rover.y - 1, instructions: rest})
  end

  def execute(%__MODULE__{orientation: "E", instructions: ["M" | rest]} = rover) do
    execute(%{rover | x: rover.x + 1, instructions: rest})
  end

  def execute(%__MODULE__{orientation: "W", instructions: ["M" | rest]} = rover) do
    execute(%{rover | x: rover.x - 1, instructions: rest})
  end

  @spec rotate_ccw(String.t()) :: String.t()
  defp rotate_ccw("N"), do: "W"
  defp rotate_ccw("W"), do: "S"
  defp rotate_ccw("S"), do: "E"
  defp rotate_ccw("E"), do: "N"

  @spec rotate_cw(String.t()) :: String.t()
  defp rotate_cw("N"), do: "E"
  defp rotate_cw("E"), do: "S"
  defp rotate_cw("S"), do: "W"
  defp rotate_cw("W"), do: "N"
end
