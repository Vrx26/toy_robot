defmodule ToyRobot.Robot do
  alias ToyRobot.Robot

  defstruct north: 0, east: 0, facing: :north

  @doc """
  Move robot east one space

  ## Examples

      iex> alias ToyRobot.Robot
      ToyRobot.Robot
      iex> robot = %Robot{north: 0, facing: :north}
      %Robot{east: 0, north: 0, facing: :north}
      iex> Robot.move(robot)
      %Robot{east: 0, north: 1, facing: :north}
      iex> robot |> Robot.move() |> Robot.move() |> Robot.move()
      %Robot{east: 0, north: 3, facing: :north}
  """
  @spec move(%ToyRobot.Robot{}) :: %ToyRobot.Robot{}
  def move(robot = %__MODULE__{facing: direction}) do
    case direction do
      :north -> robot |> move_north()
      :east -> robot |> move_east()
      :south -> robot |> move_south()
      :west -> robot |> move_west()
    end
  end

  @doc """
  Turn the robot left.

  ## Examples

      iex> alias ToyRobot.Robot
      ToyRobot.Robot
      iex> robot = %Robot{facing: :north}
      %Robot{facing: :north}
      iex> Robot.turn_left(robot)
      %Robot{east: 0, north: 0, facing: :west}
      iex> robot |> Robot.turn_left() |> Robot.turn_left() |> Robot.turn_left()
      %Robot{east: 0, north: 0, facing: :east}
  """
  @spec turn_left(%ToyRobot.Robot{}) :: %ToyRobot.Robot{}
  def turn_left(robot = %Robot{facing: direction}) do
    new_direction =
      case direction do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    %Robot{robot | facing: new_direction}
  end

  @doc """
  Turn the robot right.

  ## Examples

      iex> alias ToyRobot.Robot
      ToyRobot.Robot
      iex> robot = %Robot{facing: :north}
      %Robot{facing: :north}
      iex> Robot.turn_right(robot)
      %Robot{east: 0, north: 0, facing: :east}
      iex> robot |> Robot.turn_right() |> Robot.turn_right() |> Robot.turn_right()
      %Robot{east: 0, north: 0, facing: :west}
  """
  @spec turn_right(%ToyRobot.Robot{}) :: %ToyRobot.Robot{}
  def turn_right(robot = %Robot{facing: direction}) do
    new_direction =
      case direction do
        :north -> :east
        :west -> :north
        :south -> :west
        :east -> :south
      end

    %Robot{robot | facing: new_direction}
  end

  defp move_east(robot = %Robot{}) do
    %Robot{robot | east: robot.east + 1}
  end

  defp move_west(robot = %Robot{}) do
    %Robot{robot | east: robot.east - 1}
  end

  defp move_north(robot = %Robot{}) do
    %Robot{robot | north: robot.north + 1}
  end

  defp move_south(robot = %Robot{}) do
    %Robot{robot | north: robot.north - 1}
  end
end
