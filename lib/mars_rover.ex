defmodule MarsRover do
  @moduledoc """
  Documentation for `MarsRover`.
  """
  alias Plateau
  alias Rover

  @plateau_coord_prompt ~s(Enter coordinates of the plateau: )
  @rover_coord_prompt ~s(Enter rover coordinates: )
  @rover_instructions ~s(Enter rover instructions: )
  @add_rover_prompt ~s(Another Rover? \(Y/N\) )

  def run do
    plateau_input()
    |> rover_input()
    |> make_it_so()
  end

  @spec plateau_input() :: Plateau.t()
  defp plateau_input() do
    [x, y] = prompt_and_process(@plateau_coord_prompt)

    %Plateau{x: x, y: y}
  end

  defp rover_input(%Plateau{} = plateau, rovers \\ []) do
    [x, y, o] = prompt_and_process(@rover_coord_prompt)
    instructions = prompt_and_process(@rover_instructions)
    [another_rover] = prompt_and_process(@add_rover_prompt)

    rover = Rover.new(%{x: x, y: y, orientation: o, instructions: instructions})
    rover_input(plateau, [rover | rovers], another_rover)
  end

  defp rover_input(plateau, rover_data, "Y"), do: rover_input(plateau, rover_data)
  defp rover_input(plateau, rover_data, "N"), do: {plateau, rover_data}

  defp make_it_so({plateau, rovers}) do
    IO.puts("#{plateau.x} #{plateau.y}")

    rovers
    |> Enum.reverse()
    |> Enum.map(&Rover.full_report/1)
    |> Enum.map(&Rover.execute/1)
    |> Enum.map(&Rover.current_position/1)

    :ok
  end

  defp prompt_and_process(prompt) do
    prompt
    |> IO.gets()
    |> String.trim()
    |> String.replace(~r/\s/, "")
    |> String.split("", trim: true)
  end
end
