defmodule ToyRobot.Simulation do
  alias ToyRobot.{Simulation, Robot, Table}

  defstruct [:table, :robot]

  @doc """
  Simualate robot placement on the table

  ## Example
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> Simulation.place(table, %{north: 0, east: 0, facing: :north})
  {
    :ok,
    %Simulation{
      table: table,
      robot: %Robot{north: 0, east: 0, facing: :north}
    }
  }
  iex> Simulation.place(table, %{north: 6, east: 0, facing: :north})
  {
    :error, :invalid_placement
  }
  """
  def place(table, placement) do
    if Table.valid_position?(table, placement) do
      {
        :ok,
        %Simulation{
          table: table,
          robot: struct(Robot, placement)
        }
      }
    else
      {:error, :invalid_placement}
    end
  end

  @doc """
  Moves robot one step forward in the direction it is facing inside the simulation. Moves that resutl in robot falling down
  are prevented

  ## Example
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{
  ...>   table: table,
  ...>   robot: %Robot{north: 0, east: 0, facing: :north}
  ...> }
  iex> simulation |> Simulation.move()
  {
    :ok,
    %Simulation{
      table: table,
      robot: %Robot{
        north: 1,
        east: 0,
        facing: :north
      }
    }
  }

  ### Invalid movement

  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation =%Simulation{
  ...>   table: table,
  ...>   robot: %Robot{north: 4, east: 0, facing: :north}
  ...> }
  iex> simulation |> Simulation.move()
  {:error, :at_table_boundary}
  """
  def move(simulation = %Simulation{robot: robot, table: table}) do
    with moved_robot <- Robot.move(robot),
         true <- Table.valid_position?(table, moved_robot) do
      {:ok, %Simulation{simulation | robot: moved_robot}}
    else
      false -> {:error, :at_table_boundary}
    end
  end

  @doc """
  Turns robot left inside simulation

  ## Example
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{
  ...>   table: table,
  ...>   robot: %Robot{north: 0, east: 0, facing: :north}
  ...> }
  iex> simulation |> Simulation.turn_left()
  {
    :ok,
    %Simulation{
      table: table,
      robot: %Robot{
        north: 0,
        east: 0,
        facing: :west
      }
    }
  }
  """
  def turn_left(simulation = %Simulation{robot: robot}) do
    {:ok, %{simulation | robot: Robot.turn_left(robot)}}
  end

  @doc """
  Turns robot right inside simulation

  ## Example
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{
  ...>   table: table,
  ...>   robot: %Robot{north: 0, east: 0, facing: :north}
  ...> }
  iex> simulation |> Simulation.turn_right()
  {
    :ok,
    %Simulation{
      table: table,
      robot: %Robot{
        north: 0,
        east: 0,
        facing: :east
      }
    }
  }
  """
  def turn_right(simulation = %Simulation{robot: robot}) do
    {:ok, %{simulation | robot: Robot.turn_right(robot)}}
  end

  @doc """
  Report robot's current position inside simulation

  ## Example
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{
  ...>   table: table,
  ...>   robot: %Robot{north: 2, east: 3, facing: :west}
  ...> }
  iex> simulation |> Simulation.report()
  %Robot{north: 2, east: 3, facing: :west}
  """
  def report(%Simulation{robot: robot}), do: robot
end
