defmodule ToyRobot.Game.Player do
  use GenServer

  alias ToyRobot.{Simulation, Table}

  # Client API

  def start(position) do
    GenServer.start(__MODULE__, position)
  end

  def start_link(position) do
    GenServer.start_link(__MODULE__, position)
  end

  def move(player) do
    GenServer.cast(player, :move)
  end

  def report(player) do
    GenServer.call(player, :report)
  end

  # Server callbacks

  def init(robot) do
    simulation = %Simulation{
      table: %Table{
        north_boundary: 4,
        east_boundary: 4
      },
      robot: robot
    }

    {:ok, simulation}
  end

  def handle_call(:report, _from, simulation) do
    {:reply, Simulation.report(simulation), simulation}
  end

  def handle_cast(:move, simulation) do
    {:ok, new_simulation} = simulation |> Simulation.move()
    {:noreply, new_simulation}
  end
end
