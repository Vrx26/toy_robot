defmodule ToyRobot.CommandInterpreter do
  @doc """
  Interpret given list of commands into format readable by CommandRunner

  ## Example
  iex> alias ToyRobot.CommandInterpreter
  ToyRobot.CommandInterpreter
  iex> commands = ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "REPORT"]
  ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "REPORT"]
  iex> commands |> CommandInterpreter.interpret()
  [
   {:place, %{north: 2, east: 1, facing: :north}},
   :move,
   :turn_left,
   :turn_right,
   :report
  ]
  """
  def interpret(commands) do
    commands |> Enum.map(&do_interpret/1)
  end

  defp do_interpret(full_command = "PLACE " <> command) do
    format = ~r/^(\d+),(\d),(NORTH|SOUTH|EAST|WEST)$/

    case Regex.run(format, command) do
      [_command, x, y, facing] ->
        direction = direction(facing)

        {
          :place,
          %{
            north: String.to_integer(y),
            east: String.to_integer(x),
            facing: direction
          }
        }

      nil ->
        {:invalid, full_command}
    end
  end

  defp do_interpret("MOVE"), do: :move

  defp do_interpret("LEFT"), do: :turn_left

  defp do_interpret("RIGHT"), do: :turn_right

  defp do_interpret("REPORT"), do: :report

  defp do_interpret(command), do: {:invalid, command}

  defp direction(direction) do
    case direction do
      "NORTH" -> :north
      "EAST" -> :east
      "SOUTH" -> :south
      "WEST" -> :west
    end
  end
end
