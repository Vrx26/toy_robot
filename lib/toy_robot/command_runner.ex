defmodule ToyRobot.CommandRunner do
  alias ToyRobot.{Table, Simulation}

  def run([{:place, placement} | rest]) do
    table = %Table{north_boundary: 4, east_boundary: 4}

    case Simulation.place(table, placement) do
      {:ok, simulation} -> run(rest, simulation)
      {:error, :invalid_placement} -> run(rest)
    end
  end

  def run([_command | rest]), do: run(rest)

  def run([]), do: nil

  def run([{:invalid, _} | rest], simulation), do: run(rest, simulation)

  def run([:move | rest], simulation) do
    case Simulation.move(simulation) do
      {:ok, updated_simulation} -> run(rest, updated_simulation)
      {:error, :at_table_boundary} -> run(rest, simulation)
    end
  end

  def run([:turn_right | rest], simulation) do
    {:ok, simulation} = Simulation.turn_right(simulation)
    run(rest, simulation)
  end

  def run([:turn_left | rest], simulation) do
    {:ok, simulation} = Simulation.turn_left(simulation)
    run(rest, simulation)
  end

  def run([:report | rest], simulation) do
    %{north: north, east: east, facing: facing} = Simulation.report(simulation)

    IO.puts(
      "The robot is at (#{east}, #{north}) and is facing #{facing |> Atom.to_string() |> String.upcase()}"
    )

    run(rest, simulation)
  end

  def run([], simulation), do: simulation
end
