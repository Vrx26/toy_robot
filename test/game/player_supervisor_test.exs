defmodule Game.PlayerSupervisorTest do
  use ExUnit.Case, async: true

  alias ToyRobot.{Game.PlayerSupervisor, Robot}

  test "starts child process" do
    robot = %Robot{north: 0, east: 0, facing: :north}
    {:ok, player} = PlayerSupervisor.start_child(robot, "Jeb")

    [{registered_player, _}] = Registry.lookup(ToyRobot.Game.PlayerRegistry, "Jeb")
    assert registered_player == player
  end

  test "registry started?" do
    registry = Process.whereis(ToyRobot.Game.PlayerRegistry)
    assert registry
  end

  test "moves named robot forward" do
    robot = %Robot{north: 0, east: 0, facing: :north}
    {:ok, _player} = PlayerSupervisor.start_child(robot, "Izzy")
    PlayerSupervisor.move("Izzy")
    %Robot{north: north} = PlayerSupervisor.report("Izzy")

    assert north == 1
  end
end
